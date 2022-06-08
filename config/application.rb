# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'csv'

Bundler.require(*Rails.groups)
Time::DATE_FORMATS.merge!(default: '%Y/%m/%d %H:%M:%S', ymd: '%Y/%m/%d')
module Flycat
  class Application < Rails::Application
    config.load_defaults 6.1
<<<<<<< HEAD
    config.i18n.available_locales = %i[en zh-TW]
=======
    config.exceptions_app = routes
    config.i18n.available_locales = %i[en zh-TW ja]
>>>>>>> 476d395 (docs(錯誤訊ｐ息): 註冊)
    config.i18n.default_locale = :'zh-TW'
    config.hosts << 'flycat.works'
    config.hosts << "flycat0607.herokuapp.com"
    config.hosts << "c45a-61-220-182-115.jp.ngrok.io"
    config.action_controller.forgery_protection_origin_check = false
    config.time_zone = 'Taipei'
    config.active_record.default_timezone = :local
    config.i18n.available_locales = %i[en zh-TW ja]
    config.i18n.default_locale = :'zh-TW'
  end
end

