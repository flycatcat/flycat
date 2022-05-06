class ApplicationController < ActionController::Base
<<<<<<< HEAD
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render status: 404
  end

  def internal_server_error
    render status: 500
  end
end
=======
    include Pundit::Authorization
    # rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
    before_action :authenticate_user!
    
    # def not_found
    #   render status: 404
    # end
  
    # def internal_server_error
    #   render status: 500
    # end

    private
  
    def user_not_authorized
      flash[:notice] = "你沒有檢視該頁面的權限!"
      redirect_to root_path
    end
end
>>>>>>> 4b8e260 (feat: 🎸 NO1/12/17/18 第三方登入登入/使用者登入與登出/權限管理/新增model)
