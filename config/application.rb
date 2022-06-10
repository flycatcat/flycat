# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'csv'

Bundler.require(*Rails.groups)
Time::DATE_FORMATS.merge!(default: '%Y/%m/%d %H:%M', ymd: '%Y/%m/%d')
module Flycat
  class Application < Rails::Application
    config.load_defaults 6.1
    config.exceptions_app = routes
    config.i18n.available_locales = %i[en zh-TW ja]
    config.i18n.default_locale = :'zh-TW'
    config.hosts << 'flycat.works'
    config.hosts << 'flycat-demo-day.herokuapp.com'
    config.hosts << ENV.fetch('your_ngrok', '')
    config.action_controller.forgery_protection_origin_check = false
    config.time_zone = 'Taipei'
    config.active_record.default_timezone = :local
    config.i18n.available_locales = %i[en zh-TW ja]
    config.i18n.default_locale = :'zh-TW'
  end
end

