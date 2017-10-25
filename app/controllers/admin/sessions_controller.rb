class Admin::SessionsController < Admin::ApplicationController
  def index
    @sessions = Session.all.order('updated_at DESC').page(params[:page] || 1).per(20)
  end

  def new; end

  def create; end
end
