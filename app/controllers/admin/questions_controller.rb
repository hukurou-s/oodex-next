# frozen_string_literal: true

class Admin::QuestionsController < ApplicationController
  before_action :set_session
  before_action :set_mission
  before_action :set_problem
  before_action :set_question, only: %i[show]

  def new
    @question = @problem.questions.new
  end

  def create
    @question = Question.new(question_params)
    unless @question.save
      render :new, flash: { alert: @question.report_errors } && return
    end

    result = @question.register_test(params[:tests], params[:labels], params['pirced-location-id'])

    redirect_to action: 'show', id: @question, flash: { alert: result[:error] }
  end

  def show
    @test_list = PiercedLocation.of_question_with_test_info(@question.id)
  end

  private

  def set_question
    @question = @problem.questions.find(params[:id])
  end

  def set_problem
    @problem = @mission.problems.find(params[:problem_id])
  end

  def set_mission
    @mission = @session.missions.find(params[:mission_id])
  end

  def set_session
    @session = Session.find(params[:session_id])
  end

  def question_params
    params.require(:question).permit(
      :name,
      :detail
    ).merge(problem: @problem)
  end
end
