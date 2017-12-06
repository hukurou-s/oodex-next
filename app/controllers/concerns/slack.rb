# frozen_string_literal: true

require 'net/http'
require 'slack/incoming/webhooks'

class OodexNext::Slacker
  def initialize(url, channel)
    @url = url
    @channel = channel
  end

  def post(attachments)
    slack = Slack::Incoming::Webhooks.new(
      @url,
      channel: @channel,
      username: 'TooDex-system',
      icon_emoji: ':tea:'
    )
    slack.post 'システムからの通知です', attachments: attachments unless attachments.nil?
  end
end
