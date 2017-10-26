class Admin::MissionsController < Admin::ApplicationController
  before_action :set_session, only: %i[new]
  before_action :set_mission, only: %i[edit]

  def new
    @mission = @session.missions.new
  end

  def edit; end


  private

  def set_mission
    @mission = Mission.find(params[:id])
  end

  def set_session
    @session = Session.find(params[:session_id])
  end
end
