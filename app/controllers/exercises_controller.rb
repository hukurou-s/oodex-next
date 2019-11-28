# frozen_string_literal: true

class ExercisesController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :set_session, only: :show
  before_action :set_mission, only: :show

  def show
    problems = @mission.problems
    @problems_and_questions = Problem.search_questions_with_problem_id(problems)
    @problems_with_tests = Problem.search_tests_with_problem_id(problems)
    @questions_with_tests = Question.search_tests_with_problem_id(problems)
  end

  private

  def set_mission
    @mission = @session.missions.find(params[:mission_id])
  end

  def set_session
    @session = Session.find(params[:session_id])
  end
end
