class Admin::MissionActivityChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'repo'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
