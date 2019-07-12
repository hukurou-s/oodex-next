# frozen_string_literal: true

class Admin::ProblemsController < Admin::ApplicationController
  before_action :set_session
  before_action :set_mission
  before_action :set_problem, only: %i[show]

  def new
    @problem = @mission.problems.new
  end

  def create
    @problem = Problem.create(
      mission: @mission,
      name: params[:problem][:name],
      detail: params[:problem][:detail],
    )

    test_command_list =  @mission.test_commands
    params['pirced-location-id'].each_with_index do |id, index|
      test_name = params[:tests][index]

      test = Test.create(
        mission: @mission,
        test_name: test_name,
        test_command: test_command_list[test_name],
        pierced_location_id: id
      )

      ProblemTest.create(
        problem_id: @problem.id,
        test_id: test.id,
        pierced_level: params[:labels][index]
      )
    end

    redirect_to admin_session_mission_problems_path(params[:session_id], params[:mission_id], id: @problem.to_param)
  end

  def show; end

  private

  def set_problem
    @problem = Problem.find(params[:id])
  end

  def set_mission
    @mission = Mission.find(params[:mission_id])
  end

  def set_session
    @session = Session.find(params[:session_id])
  end

end

