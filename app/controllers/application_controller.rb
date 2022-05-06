class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render status: 404
  end

  def internal_server_error
    render status: 500
  end
end
