# frozen_string_literal: true

require 'capybara/rails'
require 'capybara/rspec'
require 'selenium-webdriver'

RSpec.configure do |config|
  config.include Capybara::DSL
end

if ENV['NO_HEADLESS'] == '1'
  base_args = %w[no-sandbox disable-gpu]
else
  base_args = %w[headless no-sandbox disable-gpu]
end

Capybara.register_driver :headless_chrome do |app|
  args = base_args.dup << '--window-size=1900,1080'
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: {
      args: args
    }
  )
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: caps
  )
end

Capybara.default_driver = :headless_chrome
