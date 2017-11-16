require 'open3'
require 'shellwords'

class RepoCloneWorker
  include Sidekiq::Worker
  sidekiq_options queue: :event

  def perform(mission_params)
    # FIXME: maybe has shell execution vulnerabilities.
    #        you should validate and escape url of mission params.
    url = Shellwords.shellescape(mission_params['repository'])
    dir_name = Shellwords.shellescape(url.match(/\/(.*)*.git/).to_s.gsub('/', ''))
    _, err, _ = Open3.capture3("git clone #{url} repos/#{dir_name}")
    logger.info "git clone #{url} -o repos/#{dir_name}"
    if err.empty?
      Mission.create(mission_params) if err.empty?
    else
      logger.error 'Fail create mission' unless err.empty?
    end
  end
end
