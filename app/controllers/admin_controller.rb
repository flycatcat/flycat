# frozen_string_literal: true

  class AdminController < ApplicationController
    layout "admin"
    def index
      @bulletins = current_company.bulletins
      @profiles = current_company.profiles
    end
  end
