# frozen_string_literal: true

# == Schema Information
#
# Table name: missions
#
#  id               :integer          not null, primary key
#  session_id       :integer          not null
#  name             :string(255)      not null
#  repository       :string(255)      not null
#  local_repository :string(255)      not null
#  detail           :text(65535)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Mission < ApplicationRecord
  using JavaFileExtensions
  has_many :pierced_locations
  belongs_to :session

  def java_files(absolute = false)
    java_files = files.grep(/\.java/)
    return java_files if absolute
    java_files.map { |f| f.gsub(Regexp.new(absolute_path), '') }
  end

  def java_main_files
    java_files.grep(/.*main*/)
  end

  def java_test_files
    java_files.grep(/.*test*/)
  end

  def java_main_contents
    java_files(true).grep_v(%r{/test}).map do |p|
      name = p.to_relative_path(local_repository)
      { name => File.read(p) }
    end
  end

  private

  def files
    @files = Dir.glob("#{absolute_path}/**/*").sort if @files.nil?
    @files
  end

  def absolute_path
    @absolute_path = Rails.root.join(local_repository).to_s if @absolute_path.nil?
    @absolute_path
  end
end
