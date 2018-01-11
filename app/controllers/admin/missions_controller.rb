# frozen_string_literal: true

class Admin::MissionsController < Admin::ApplicationController
  before_action :set_session, only: %i[new]
  before_action :set_mission, only: %i[edit show]

  def new
    @mission = @session.missions.new
  end

  def create
    hash = mission_params.merge(session_id: params[:session_id]).to_h
    RepoCloneWorker.perform_async(hash)
    ActionCable.server.broadcast 'repo', status: 'uploading'
  end

  def edit; end

  def show; end

  def update
    binding.pry
  end

  private

  def mission_params
    params.require(:mission).permit(
      :repository,
      :name,
      :detail
    )
  end

  def set_mission
    @mission = Mission.find(params[:id])
  end

  def set_session
    @session = Session.find(params[:session_id])
  end
end
