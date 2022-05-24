class EventsController < ApplicationController
    before_action :find_event, only: [:show, :edit, :update, :destroy]
    before_action :find_work_shift, except: [:destroy]
    
    def index
      start_date = params[:start]
      end_date = params[:end]
      work_shift_id = params[:work_shift_id]
      @events = Event.where("start_time >= ? AND end_time <= ? And work_shift_id = ?", start_date, end_date, work_shift_id)
    end
  
    def show
    end
  
    def new
      @event = Event.new
    end
  
    def edit
    end
  
    def create
      @event = Event.new(event_params.merge(work_shift_id: params[:work_shift_id]))
      if @event.save
        redirect_to sets_work_shift_path, notice: '新增成功!'
      else
        render :new
      end 
    end
  
    def update
      if @event.update(event_params)
        redirect_to sets_work_shift_path, notice: '更新成功!'
      else
        render :edit
      end
    end
  
    def destroy
      @event.destroy
      redirect_to sets_work_shift_path, notice: '刪除成功'
    end
  
    private
    def find_work_shift
      @work_shift = WorkShift.find(params[:work_shift_id])
    end
  
    def find_event
      @event = Event.find(params[:event_id])
    end
  
    def event_params
      params.require(:event).permit(:all_day, :start_time, :end_time, :title, :content, :vacation_set)
    end
  end
