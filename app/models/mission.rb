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
  has_many :problems
  belongs_to :session

  def java_files(absolute = false)
    java_files = files.grep(/\.java/)
    return java_files if absolute
    java_files.map { |f| f.gsub(Regexp.new(absolute_path), '') }
  end

  def test_names
    json = File.read "#{local_repository}/tests.json"
    JSON.parse(json).map { |i| i['name'] }
  end

  def test_commands
    json = File.read "#{local_repository}/tests.json"
    names = JSON.parse(json).map { |i| i['name'] }
    commands = JSON.parse(json).map { |i| i['command'] }
    Hash[names.zip(commands)]
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

  def java_pierced_contents
    java_contents = java_contents_per_lines
    pierced_locations.order('file_name DESC').order('location_id DESC').each do |p|
      java_contents[p.file_name].slice!(p.lines[0], p.lines.length)
    end
    java_contents.map { |file, content| { file => content.join("\n") } }
  end

  def java_contents_per_lines
    java_main_contents.map { |content| [content.keys[0], content.values[0].split(/\n/)] }.to_h
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
