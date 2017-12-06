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
  belongs_to :session

  def java_files
    files.grep(/\.java/)
  end

  def java_main_files
    java_files.grep(/.*main*/)
  end

  def java_test_files
    java_files.grep(/.*test*/)
  end

  private

  def files
    Dir.glob("#{absolute_path}/**/*")
  end

  def absolute_path
    Rails.root.join(local_repository)
  end
end
