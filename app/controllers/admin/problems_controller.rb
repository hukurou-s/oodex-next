# frozen_string_literal: true

class Admin::ProblemsController < Admin::ApplicationController
  before_action :set_session
  before_action :set_mission

  def new
    @problem = @mission.problems.new
  end

  private

  def set_mission
    @mission = Mission.find(params[:mission_id])
  end

  def set_session
    @session = Session.find(params[:session_id])
  end
end
