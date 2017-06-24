require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Coursify
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    require 'rack-cas/session_store/active_record'
    config.rack_cas.session_store = RackCAS::ActiveRecordStore
    config.rack_cas.extra_attributes_filter = %w(email name)
  end
end
