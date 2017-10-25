class TopController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    @sessions = Session.all.order('updated_at DESC').page(params[:page] || 1).per(20)
  end
end
