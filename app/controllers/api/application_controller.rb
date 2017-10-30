# frozen_string_literal: true

class Api::ApplicationController < ActionController::API
  protected

  def render_400(message = 'Bad Request')
    render json: {
      message: message,
      status: 400
    }, status: 400
  end

  def render_401(message = 'Unauthorized')
    render json: {
      message: message,
      status: 401
    }, status: 401
  end

  def render_404(message = 'Not found')
    render json: {
      message: message,
      status: 404
    }, status: 404
  end

  def authenticate_user!
    render_401 unless user_signed_in?
  end

  def current_user
    return nil unless user_signed_in?
    @user
  end

  def user_signed_in?
    return false unless params[:token]
    @user = User.find_by(token: params[:token]) if @user.nil?
    return false if @user.nil?
    true
  end
end
