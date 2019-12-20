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
      locations_params(file).map do |key, value|
        PiercedLocation.create(mission: @mission,
                               lines: value,
                               file_name: file,
                               location_id: key + 1)
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

  def locations_params(file)
    locations = params[:locations].fetch(file, nil)&.permit!.to_h
    keys = locations.keys.map(&:to_i)
    values = locations.values.map do |value|
      next unless value.respond_to?(:map)
      value.map(&:to_i)
    end
    Hash[keys.zip(sort_serialized_arrays(values))]
  end

  def sort_serialized_arrays(arrays)
    arrays.sort_by { |a| a[0] }
  end

  def set_mission
    @mission = Mission.find(params[:id])
  end

  def set_session
    @session = Session.find(params[:session_id])
  end
end
