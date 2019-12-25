# frozen_string_literal: true

class Api::SubmissionsController < Api::ApplicationController
  def question
    print params

    render json: params
  end
end
