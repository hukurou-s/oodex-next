# frozen_string_literal: true

require 'open3'
require 'shellwords'

class RepoCloneWorker
  include Sidekiq::Worker
  include Rails.application.routes.url_helpers

  sidekiq_options queue: :event

  def perform(mission_params)
    @mission_params = mission_params
    err = clone_repository_from_github
    if err.empty?
      mission = Mission.create(params)
      ActionCable.server.broadcast 'repo', status: 'done', to: to(mission.id)
    else
      logger.error "Fail create mission: #{err}"
      ActionCable.server.broadcast 'repo', status: 'fail'
    end
  end

  private

  # generate redirect to url after clone repository.
  # @param {Integer} id
  def to(id)
    admin_session_mission_path(mission_params['session_id'], id)
  end

  def clone_repository_from_github
    mkdir 'repo', unix_time
    _, err, = Open3.capture3(git_clone)
    err
  end

  def params
    @mission_params.merge(local_repository: local_path)
  end

  def git_clone
    "git clone -q #{url} #{local_path}"
  end

  def url
    # FIXME: maybe has shell execution vulnerabilities.
    #        you should validate and escape url of mission params.
    Shellwords.shellescape(@mission_params['repository'])
  end

  def local_path
    dir_name = url.match(%r{(/.*).git}).to_s.delete('/')
    "repo/#{unix_time}/#{dir_name}"
  end

  def unix_time
    @unix_time = Time.now.to_i.to_s if @unix_time.nil?
    @unix_time
  end

  def mkdir(*paths)
    Dir.mkdir(Rails.root.join(*paths), 0o755)
  end
end
