# frozen_string_literal: true

class Admin::SessionsController < Admin::ApplicationController
  before_action :set_session, only: %i[edit update activate inactivate show]

  def index
    sessions = Session.all.order('created_at DESC')
    @q = sessions.ransack(params[:q])
    @sessions = @q.result&.page(params[:page] || 1)&.per(20)
  end

  def new
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)
    if @session.save
      flash[:notice] = '授業を作成しました'
      redirect_to action: :index
    else
      logger.info session_errors: @session.errors.full_messages
      flash[:alert] = "授業の作成に失敗しました #{@session.errors.full_messages.join(' ')}"
      render :new
    end
  end

  def edit; end

  def show
    @q = @session.missions.ransack(params[:q])
    @missions = @q.result&.page(params[:page] || 1)&.per(20)
  end

  def update
    if @session.update(session_params)
      flash[:notice] = '授業を更新しました'
      redirect_to action: :index
    else
      logger.info session_errors: @session.errors.full_messages
      flash[:alert] = "授業の更新に失敗しました #{@session.errors.full_messages.join(' ')}"
      render :edit
    end
  end

  def activate
    @session.active!
    redirect_to action: :index
  end

  def inactivate
    @session.inactive!
    redirect_to action: :index
  end

  private

  def set_session
    @session = Session.find(params[:id] || params[:session_id])
  end

  def session_params
    params.require(:session).permit(
      :name,
      :detail,
      :start_at,
      :end_at
    )
  end
end
