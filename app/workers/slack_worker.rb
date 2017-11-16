# frozen_string_literal: true

require_relative '../controllers/concerns/slack'

class SlackWorker
  include Sidekiq::Worker
  sidekiq_options queue: :event
  sidekiq_options retry: false

  def perform(attachments)
    slack = OodexNext::Slacker.new(
      ENV['INQUIRY_SLACK_URL'],
      ENV['INQUIRY_SLACK_CHANNEL']
    )
    slack.post(attachments)
  end
end
