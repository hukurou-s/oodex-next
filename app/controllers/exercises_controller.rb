# frozen_string_literal: true

class ExercisesController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :set_session, only: :show
  before_action :set_mission, only: :show

  def show
    problems = @mission.problems
    @problems_questions = {}
    problems.each do |p|
      @problems_questions[p] = p.questions
    end
  end

  private

  def set_mission
    @mission = @session.missions.find(params[:mission_id])
  end

  def set_session
    @session = Session.find(params[:session_id])
  end
end