# frozen_string_literal: true

class TopController < ApplicationController
  before_action :authenticate_user!, only: :index

  def index
    sessions = Session.in_active.by_created
    @q = sessions.ransack(params[:q])
    @sessions = @q.result&.page(params[:page] || 1)&.per(20)
  end
end
