# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Flycat
  class Application < Rails::Application
    config.load_defaults 6.1
    config.exceptions_app = routes
    config.i18n.available_locales = %i[en zh-TW] # 支援語系
    config.i18n.default_locale = :'zh-TW' # 預設語系
    config.hosts << "a95c-2001-b400-e23c-6d34-2eb4-65c0-9e2d-89ff.jp.ngrok.io" 
    # 更換成自己的ngrok
    config.hosts << 'dev.flycat.works'
    config.action_controller.forgery_protection_origin_check = false
    # 設定時區為臺北時間
    config.time_zone = "Taipei"
    config.active_record.default_timezone = :local
    config.i18n.available_locales = [:en, :'zh-TW'] #支援語系
    config.i18n.default_locale = :'zh-TW' #預設語系
  end
end
