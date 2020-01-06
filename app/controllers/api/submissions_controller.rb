# frozen_string_literal: true

class Api::SubmissionsController < ApplicationController
  before_action :set_question, only: %i[question]

  def question
    @submit = Submit.new(submit_params)
    @s_q = @submit.build_submit_question(submit_question_params)
    @code = new_submit_codes
    @submit.save

    exec_testing_job
    render status: 200, json: { status: 'success' }
  end

  private

  def exec_testing_job
    QuestionTestWorker.perform_async(@submit.id, @submit.mission_id, @question.id)
    ExerciseActivityChannel.broadcast_to current_user, status: 'testing'
  end

  def new_submit_codes
    pierced_locations = PiercedLocation.where(mission_id: @question.problem.mission)
    code = code_param.map do |key, value|
      pierced_location = pierced_locations.find { |pl| pl.location_id == key.to_i }
      @submit.submit_codes.build(submit_codes_params(value, pierced_location))
    end
    code
  end

  def submit_params
    {
      user_id: current_user.id,
      mission_id: @question.problem.mission.id
    }
  end

  def submit_question_params
    {
      submit_id: @submit.id,
      question_id: @question.id
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

  def set_question
    @question ||= Question.find(params.require(:id))
  end
end
