class WorkShiftsController < ApplicationController
  before_action :find_work_shift, only: [:edit, :update, :destroy, :set, :regular_holiday]

  def index
    @work_shifts = current_company.work_shifts
  end
    
  def new
    @work_shift = current_company.work_shifts.new
  end
    
  def create
    @work_shift = current_company.work_shifts.new(work_shift_params)
    if @work_shift.save
      redirect_to work_shifts_path
    else
      render :new
    end
  end
    
  def edit
  end
    
  def update
    
    if @work_shift.update(work_shift_params)
        redirect_to work_shifts_path 
    else
        render :edit
    end
  end
    
  def destroy
    @work_shift.destroy
    redirect_to work_shifts_path
  end

  def set
    @work_shift = WorkShift.find(params[:work_shift_id])
  end
      
  private
    
    def work_shift_params
      params.require(:work_shift).permit(:title, :kind)
    end

    def find_work_shift
      @work_shift = WorkShift.find(params[:work_shift_id])
    end
end
