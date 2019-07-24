# frozen_string_literal: true

class Admin::ProblemsController < Admin::ApplicationController
  before_action :set_session
  before_action :set_mission
  before_action :set_problem, only: %i[show]

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
      flash[:alert] = @problem.report_errors
      render :new && return
    end

    result = @problem.register_test(params[:tests], params[:labels], params['pirced-location-id'])
    flash[:alert] = result[:error]

    redirect_to action: 'show', id: @problem
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
