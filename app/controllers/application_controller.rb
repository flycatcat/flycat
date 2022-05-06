class ApplicationController < ActionController::Base
<<<<<<< Updated upstream
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render status: 404
  end

  def internal_server_error
    render status: 500
  end
end
=======
    # include Pundit::Authorization
    
    before_action :authenticate_user!
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
    private
  
    def user_not_authorized
      flash[:notice] = "你沒有檢視該頁面的權限!"
      redirect_to root_path
    end
end
>>>>>>> Stashed changes
