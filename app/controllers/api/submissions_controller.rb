# frozen_string_literal: true

class Api::SubmissionsController < ApplicationController
  def question
    logger.debug(current_user.id)
    render json: {}
  end
end
