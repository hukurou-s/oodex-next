# frozen_string_literal: true

class Admin::QuestionsController < ApplicationController
  before_action :set_session
  before_action :set_mission
  before_action :set_problem

  def new
    @question = @problem.questions.new
  end

  private

  def set_problem
    @problem = @mission.problems.find(params[:problem_id])
  end

  def set_mission
    @mission = @session.missions.find(params[:mission_id])
  end

  def set_session
    @session = Session.find(params[:session_id])
  end
end
