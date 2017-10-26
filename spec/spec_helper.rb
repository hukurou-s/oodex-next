# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'

require 'simplecov'
require 'simplecov-cobertura'
require 'codacy-coverage'

# require 'webmock/rspec'
# WebMock.disable_net_connect!(allow_localhost: true)

# save to CircleCI's artifacts directory if we're on CircleCI
if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
  SimpleCov.coverage_dir(dir)
end

SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::CoberturaFormatter,
    Codacy::Formatter
  ]
)

SimpleCov.start do
  add_filter '.gems'
  add_filter 'pkg'
  add_filter 'spec'
  add_filter 'vendor'
end if ENV['CI']

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

# Load support files
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.include FactoryGirl::Syntax::Methods
  config.include RSpec::Rails::ViewRendering
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.example_status_persistence_file_path = 'examples.txt'
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false
end
