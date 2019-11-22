# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :authenticate_user!, only: :show
  before_action :set_session, only: :show

  def show
    missions = @session.missions
    @missions_problems = {}
    missions.each do |m|
      @missions_problems[m] = m.problems
    end
  end

  private

  def set_session
    @session = Session.find(params[:id] || params[:session_id])
  end
end
