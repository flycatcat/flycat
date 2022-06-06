# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'csv'

Bundler.require(*Rails.groups)
Time::DATE_FORMATS.merge!(default: '%Y/%m/%d %H:%M:%S', ymd: '%Y/%m/%d')
module Flycat
  class Application < Rails::Application
    config.load_defaults 6.1
    config.i18n.available_locales = %i[en zh-TW]
    config.i18n.default_locale = :'zh-TW'
    config.hosts << 'flycat.works'
    config.hosts << "9e46-2001-b400-e23b-24cb-6362-519f-8292-9877.jp.ngrok.io"
    config.action_controller.forgery_protection_origin_check = false
    config.time_zone = 'Taipei'
    config.active_record.default_timezone = :local
    config.i18n.available_locales = %i[en zh-TW]
    config.i18n.default_locale = :'zh-TW'
  end
end
