# frozen_string_literal: true

class ExercisesController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :set_session, only: :show
  before_action :set_mission, only: :show

  def show
    @problems = @mission.problems.order(:name)
    @questions = Question.of_problem(@problems).order(:name)
    @problems_with_tests = PiercedLocation.of_problem_with_test_info(@problems)
    # Problem.search_tests_with_problem_id(@problems)
    @questions_with_tests = PiercedLocation.of_question_with_test_info(@questions)
    # Question.search_tests_with_problem_id(@problems)
    @java_pierced_contents = @mission.java_pierced_contents
  end

  private

  def set_mission
    @mission = @session.missions.find(params[:mission_id])
  end

  def set_session
    @session = Session.find(params[:session_id])
  end
end
