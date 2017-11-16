# frozen_string_literal: true

require 'open3'
require 'shellwords'

class RepoCloneWorker
  include Sidekiq::Worker
  sidekiq_options queue: :event

  def perform(mission_params)
    command = generate_eval_str mission_params
    _, err, = Open3.capture3(command)
    logger.info command
    if err.empty?
      Mission.create(mission_params) if err.empty?
    else
      logger.error 'Fail create mission' unless err.empty?
    end
  end

  private

  def generate_eval_str(mission_params)
    # FIXME: maybe has shell execution vulnerabilities.
    #        you should validate and escape url of mission params.
    url = Shellwords.shellescape(mission_params['repository'])
    dir_name = url.match(%r{/(.*)*.git/}).to_s.delete('/')
    "git clone #{url} -o repos/#{dir_name}"
  end
end
