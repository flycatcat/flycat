class VacationsController < ApplicationController
  before_action :set_vacation, only: %i[ show edit update destroy ]

  def index
    if current_user.role == "admin" || "manager"
      @vacations = current_company.vacations
    else
      @vacations = current_user.vacations
    end  
  end

  def show
  end

  def new
    @vacation = current_user.vacations.new
  end

  def edit
  end


  def create
    @vacation = current_company.vacations.new(vacation_combine_id)
    if @vacation.save
      redirect_to vacations_path, notice: "假單申請成功."
    else
      render :new
    end
  end



  def update
    # authorize :vacation
    if @vacation.update(vacation_params)
      redirect_to vacations_path, notice: '更新成功'
    else
      render :edit
    end
  end

  def destroy
    @vacation.update(deleted_at: Time.now)
    redirect_to vacations_path, notice: '已刪除假單'
  end


  private

  def set_vacation
    @vacation = Vacation.find(params[:id])
  end

  def vacation_params
    params.require(:vacation).permit(:vacation_type, :vacation_at, :status, :reason, :company_id)
  end

  def vacation_combine_id
    vacation_params.merge(user_id: current_user.id)
  end

end
