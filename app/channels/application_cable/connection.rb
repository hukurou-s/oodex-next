# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      User.find(user_session['warden.user.user.key'][0][0])
    rescue ActiveRecord::RecordNotFound
      reject_unauthorized_connection
    end

    def user_session
      @user_session ||= cookies.encrypted[Rails.application.config.session_options[:key]]
    end
  end
end
