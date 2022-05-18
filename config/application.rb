# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Flycat
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.exceptions_app = routes
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.available_locales = %i[en zh-TW] # 支援語系
    config.i18n.default_locale = :'zh-TW' # 預設語系
    config.hosts << '82be-110-28-192-189.jp.ngrok.io' # 更換成自己的ngrok
    config.hosts << 'dev.flycat.works'
    config.action_controller.forgery_protection_origin_check = false
    # 設定時區為臺北時間
    config.time_zone = 'Taipei'
  end
end
