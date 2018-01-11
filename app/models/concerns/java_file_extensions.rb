# frozen_string_literal: true

module JavaFileExtensions
  refine String do
    def to_relative_path(local_repository)
      absolute_path = Rails.root.join(local_repository).to_s
      gsub(Regexp.new(absolute_path), '')
    end
  end
end
