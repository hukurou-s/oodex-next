# frozen_string_literal: true

class Api::UsersController < Api::ApplicationController
  def sign_in
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      user.ensure_authentication_token
      render json: user
    else
      render_400
    end
  end

  def sign_out
    user = User.find_by(token: params[:token])
    user.delete_authentication_token
    render json: { messages: 'success' }, status: 200
  end
end
