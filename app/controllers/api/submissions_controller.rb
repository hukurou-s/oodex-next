# frozen_string_literal: true

class Api::SubmissionsController < ApplicationController
  before_action :set_question, only: %i[question]

  def question
    logger.debug params[:file_name]
    logger.debug params[:code]

    @submit = Submit.new(submit_params)
    logger.debug @submit.inspect
    @s_b = @submit.build_submit_question({
                                         submit_id: @submit.id,
                                         question_id: @question.id
                                       })
    logger.debug @s_b.inspect
    pierced_locations = PiercedLocation.where(mission_id: @question.problem.mission)
    Hash[params[:code].permit!].sort.to_h.each do |key, value|
      pierced_location = pierced_locations.find { |pl| pl.location_id == key.to_i }
      code = @submit.submit_codes.build({
                                  submit_id: @submit,
                                  file_name: params[:file_name],
                                  code: value,
                                  pierced_location_id: pierced_location.id
                                })
      logger.debug code.inspect
    end

    # create testing job
    render json: {}
  end

  private
  def submit_params
    {
      user_id: current_user.id,
      mission_id: @question.problem.mission.id
    }
  end

  def set_question
    @question ||= Question.find(params.require(:id))
  end
end
