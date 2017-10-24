require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module OodexNext
  class Application < Rails::Application
    config.load_defaults 5.1

    config.generators.system_tests = nil

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_types = %i[datetime time]
    config.assets.paths << config.root.join('node_modules')

    config.sass.preferred_syntax = :sass
    config.sass.line_comments = false
    config.sass.cache = false
    config.i18n.default_locale = :ja


    config.rack_dev_mark.enable = !Rails.env.production?

    # Don't generate helper and assets
    config.generators do |g|
      g.helper false
      g.assets false
    end

    config.generators.system_tests = nil
  end
end
