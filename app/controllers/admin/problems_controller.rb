# frozen_string_literal: true

class Admin::ProblemsController < Admin::ApplicationController
  before_action :set_session
  before_action :set_mission
  before_action :set_problem, only: %i[edit show update]

  def index
    problems = Problem.where('mission_id = ?', @mission.id).order('name')
    @q = problems.ransack(params[:q])
    @problems = @q.result&.page(params[:page] || 1)&.per(10)
  end

  def new
    @problem = @mission.problems.new
  end

  def create
    @problem = Problem.new(problem_params)
    unless @problem.save
      # flash[:alert] = @problem.report_errors
      render :new, flash: { alert: @problem.report_errors } && return
    end

    result = @problem.register_test(params[:tests], params[:labels], params['pirced-location-id'])
    # flash[:alert] = result[:error]

    redirect_to action: 'show', id: @problem, flash: { alert: result[:error] }
  end

  def edit; end

  def show
    @test_list = PiercedLocation.joins(tests: [problem_tests: :problem])
                                .merge(Problem.where(id: @problem.id))
                                .select(
                                  'pierced_locations.lines, tests.test_name, tests.test_command,
                                  problem_tests.score, problem_tests.pierced_level'
                                )
  end

  def update
    if @problem.update(problem_params)
      flash[:notice] = '大問を更新しました'
      redirect_to action: 'index'
    else
      flash[:alert] = @problem.report_errors
    end
  end

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
