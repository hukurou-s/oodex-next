class Admin::MissionsController < Admin::ApplicationController
  before_action :set_session, only: :new

  def new
    @mission = @session.mission.new
  end

  private

  def set_session
    @session = Session.find(params[:session_id])
  end
end
