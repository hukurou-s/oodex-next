# frozen_string_literal: true

class Admin::MissionsController < Admin::ApplicationController
  before_action :set_session, only: %i[new]
  before_action :set_mission, only: %i[edit show update]

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
    @mission.java_files.each do |file|
      params[:locations].fetch(file, nil)&.permit!.to_h.map do |key, value|
        next unless value.respond_to?(:map)
        PiercedLocation.create(
          mission: @mission,
          lines: value.map(&:to_i),
          file_name: file,
          location_id: (key.to_i + 1)
        )
      end
    end
    redirect_to new_admin_session_mission_problem_path(params[:session_id], params[:id])
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
