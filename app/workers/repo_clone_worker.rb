# frozen_string_literal: true

require 'open3'
require 'shellwords'

class RepoCloneWorker
  include Sidekiq::Worker
  sidekiq_options queue: :event

  def perform(mission_params)
    @mission_params = mission_params
    _, err, = Open3.capture3(git_clone)
    if err.empty?
      Mission.create(params) if err.empty?
    else
      logger.error 'Fail create mission' unless err.empty?
    end
  end

  private

  def params
    @mission_params.merge({ local_repository: local_path })
  end

  def git_clone
    "git clone #{url} #{local_path}"
  end

  def url
    Shellwords.shellescape(@mission_params['repository'])
  end

  def local_path
    # FIXME: maybe has shell execution vulnerabilities.
    #        you should validate and escape url of mission params.
    dir_name = url.match(%r{(/.*).git}).to_s.delete('/')
    time = Time.now.to_i.to_s
    "repo/#{time}/#{dir_name}"
  end
end
