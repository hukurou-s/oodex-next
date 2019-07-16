# frozen_string_literal: true

class Admin::ProblemsController < Admin::ApplicationController
  before_action :set_session
  before_action :set_mission
  before_action :set_problem, only: %i[show]

  def new
    @problem = @mission.problems.new
  end

  def create
    @problem = Problem.new(problem_params)
    unless @problem.save
      logger.info problem_errors: @problem.errors.full_messages
      flash[:alert] = "fail to create problem #{@problem.errors.full_messages.join(' ')}"
      render :new
    end

    test_command_list = @mission.test_commands
    tests = Test.where("mission_id = ?", params[:mission_id])

    params[:tests].each_with_index do |test, index|
      @test = tests.find_by(test_name: test)
      if @test.nil?
        @test = Test.new(
          mission: @mission,
          test_name: test,
          test_command: test_command_list[test],
          pierced_location_id: params['pirced-location-id'][index]
        )
      end

      @problem_test = @test.problem_tests.build(
        problem: @problem,
        pierced_level: params[:labels][index]
      )
      unless @test.save
        logger.info test_errors: @test.errors.full_messages
        flash[:alert] = "fail to create test #{@test.errors.full_messages.join(' ')}"
        render :new
      end
    end

    redirect_to admin_session_mission_problems_path(
                  params[:session_id],
                  params[:mission_id],
                  id: @problem.to_param
                )
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

  def problem_params
    params.require(:problem).permit(
      :name,
      :detail
    ).merge(mission: @mission)
  end
end
