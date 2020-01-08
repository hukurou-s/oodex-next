# frozen_string_literal: true

class Api::SubmissionsController < ApplicationController
  before_action :set_problem, only: %i[problem]
  before_action :set_question, only: %i[question]
  before_action :set_mission

  def problem
    @submit = Submit.new(submit_params)
    @s_p = @submit.build_submit_problem(submit_problem_params)
    @code = new_submit_codes
    @submit.save

    exec_problem_testing_job
    render status: 200, json: { status: 'success' }
  end

  def question
    @submit = Submit.new(submit_params)
    @s_q = @submit.build_submit_question(submit_question_params)
    @code = new_submit_codes
    @submit.save

    exec_question_testing_job
    render status: 200, json: { status: 'success' }
  end

  private

  # only problem

  def exec_problem_testing_job
    ProblemTestWorker.perform_async(@submit.id, @mission.id, @problem.id)
    ExerciseActivityChannel.broadcast_to current_user, status: 'testing'
  end

  def submit_problem_params
    {
      submit_id: @submit.id,
      problem_id: @problem.id
    }
  end

  def set_problem
    @problem = Problem.find(params.require(:id))
    @question = nil
  end

  # only question

  def exec_question_testing_job
    QuestionTestWorker.perform_async(@submit.id, @mission.id, @question.id)
    ExerciseActivityChannel.broadcast_to current_user, status: 'testing'
  end

  def submit_question_params
    {
      submit_id: @submit.id,
      question_id: @question.id
    }
  end

  def set_question
    @question = Question.find(params.require(:id))
    @problem = nil
  end

  # share

  def set_mission
    @mission = if @problem
                 @problem.mission
               else
                 @question.problem.mission
               end
    @mission
  end

  def new_submit_codes
    pierced_locations = PiercedLocation.where(mission_id: @mission)
    code = code_param.map do |key, value|
      pierced_location = pierced_locations.find { |pl| pl.location_id == key.to_i }
      @submit.submit_codes.build(submit_codes_params(value, pierced_location))
    end
    code
  end

  def submit_params
    {
      user_id: current_user.id,
      mission_id: @mission.id
    }
  end

  def submit_codes_params(code, pierced_location)
    params.permit(:file_name).merge(
      submit_id: @submit.id,
      code: code,
      pierced_location_id: pierced_location.id
    )
  end

  def code_param
    Hash[params[:code].permit!].sort.to_h
  end
end
