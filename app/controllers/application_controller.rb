# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def authenticate_ta!
    return false if current_user.nil?
    render 'errors/notfound', status: 404 unless %w[ta admin super].include? current_user.role
  end

  def authenticate_admin!
    return false if current_user.nil?
    render 'errors/notfound', status: 404 unless %w[admin super].include? current_user.role
  end

  private

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end
end
