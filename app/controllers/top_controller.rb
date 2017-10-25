class TopController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    sessions = Session.all.order('updated_at DESC')
    @q = sessions.ransack(params[:q])
    @sessions = @q.result.page(params[:page] || 1).per(20)
  end
end
