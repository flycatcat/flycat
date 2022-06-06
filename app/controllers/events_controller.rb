# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :update, :destroy]
  before_action :find_work_shift, except: [:destroy]
    
  def index
    start_at = params[:start]
    end_at = params[:end]
    work_shift_id = params[:work_shift_id]
    @events = Event.where("start_at >= ? AND end_at <= ? And work_shift_id = ?", start_at, end_at, work_shift_id)
  end
  
  def show
  end
  
  def new
    @event = Event.new
    @on_duty_staff = [""]+current_company.profiles.where(work_shift_title: WorkShift.find(params[:work_shift_id]).title).map{|p| p.staff_no+'_'+p.name}
  end
  
  def edit
    @on_duty_staff = [""]+current_company.profiles.where(work_shift_title: WorkShift.find(params[:work_shift_id]).title).map{|p| p.staff_no+'_'+p.name}
  end
  
  def create
    if params["event"]["shifted_mode"]=="一般"
      @event = Event.new(event_params.merge(work_shift_id: params[:work_shift_id]))
      if @event.save
        redirect_to setting_work_shift_path(id: params[:work_shift_id]), notice: '新增成功!'
      else
        render :new  
      end
    elsif params["event"]["shifted_mode"] == "循環工作"
      holidays = holidays(params["event"]["shifted_mode"])
      work_titles = work_titles("工作日")
      fail_times = []
      start_at = time_split(params["event"]["start_at"])
      end_at = time_split(params["event"]["end_at"])
      #將選定時間區間切割為每日循環排定工作
      Date.new(start_at[0],start_at[1],start_at[2]).upto(Date.new(end_at[0],end_at[1],end_at[2])) {|date|
        date_split = time_split(date.to_formatted_s(:db))
        check_start = DateTime.new(date_split[0],date_split[1],date_split[2],start_at[3],start_at[4])
        check_end = DateTime.new(date_split[0],date_split[1],date_split[2],end_at[3],end_at[4])
        holiday_check = holiday_check(check_start,check_end,holidays)
        work_title_check = work_title_check(check_start,check_end,work_titles)
        if (holiday_check.sum > 0) || (work_title_check.sum >0)
          fail_times << 0
        else
          event = event_time_change(check_start.to_formatted_s(:db),check_end.to_formatted_s(:db))
          if check_end <= check_start
            fail_times << 2
          elsif params["event"]["title"] == ""
            fail_times << 3
          elsif event.save
            fail_times << 0
          else 
            fail_times << 1
          end
        end
      }
      if fail_times.include?(2)
        redirect_to setting_work_shift_path(id: params[:work_shift_id]), notice: '每日結束時間需大於開始時間'
      elsif fail_times.include?(3)
        redirect_to setting_work_shift_path(id: params[:work_shift_id]), notice: '未輸入標題'
      elsif fail_times.sum == 0 
        redirect_to setting_work_shift_path(id: params[:work_shift_id]), notice: '新增成功!'
      else
        redirect_to setting_work_shift_path(id: params[:work_shift_id]), notice: '發生錯誤，請重新執行!'
      end 
    elsif params["event"]["shifted_mode"] == "循環例假"
      holidays = holidays(params["event"]["shifted_mode"])
      fail_times = []
      start_at = time_split(params["event"]["start_at"])
      end_at = time_split(params["event"]["end_at"])
      #將選定時間區間切割為每日循環排定例假
      Date.new(start_at[0],start_at[1],start_at[2]).upto(Date.new(end_at[0],end_at[1],end_at[2])) {|date|
        date_split = time_split(date.to_formatted_s(:db))
        check_start = DateTime.new(date_split[0],date_split[1],date_split[2],start_at[3],start_at[4])
        check_end = DateTime.new(date_split[0],date_split[1],date_split[2],end_at[3],end_at[4])
        holiday_check = holiday_check(check_start,check_end,holidays)
        if [0,6].include?(date.wday) 
          if holiday_check.sum > 0
            fail_times << 0
          else
            event = event_time_change(check_start.to_formatted_s(:db),check_end.to_formatted_s(:db))
            if check_end <= check_start
              fail_times << 2
            elsif params["event"]["title"] == ""
              fail_times << 3
            elsif event.save
              fail_times << 0
            else 
              fail_times << 1
            end
          end
        else
          fail_times << 0
        end
      }
      if fail_times.include?(2)
        redirect_to setting_work_shift_path(id: params[:work_shift_id]), notice: '每日結束時間需大於開始時間'
      elsif fail_times.include?(3)
        redirect_to setting_work_shift_path(id: params[:work_shift_id]), notice: '未輸入標題'
      elsif fail_times.sum == 0 
        redirect_to setting_work_shift_path(id: params[:work_shift_id]), notice: '新增成功!'
      else
        redirect_to setting_work_shift_path(id: params[:work_shift_id]), notice: '發生錯誤，請重新執行!'
      end 
    else
      start_at = time_split(params["event"]["start_at"])
      end_at = time_split(params["event"]["end_at"])
      events = Event.where("start_at >= ? AND end_at <= ? And work_shift_id = ?", Date.new(start_at[0],start_at[1],start_at[2]), Date.new(end_at[0],end_at[1],end_at[2]), params[:work_shift_id])
      events.each do |event|
        event.destroy
      end   
      redirect_to setting_work_shift_path(id: params[:work_shift_id]), notice: '刪除成功'
    end
  end
  
  def update
    if @event.update(event_params)
      redirect_to setting_work_shift_path(id: params[:work_shift_id]), notice: '更新成功!'
    else
      render :edit
  end
  
  def destroy
    @event.destroy
    redirect_to setting_work_shift_path(id: params[:work_shift_id]), notice: '刪除成功'
  end
  
  private
  def find_work_shift
    @work_shift = WorkShift.find(params[:work_shift_id])
  end
  
  def find_event
    @event = Event.find(params[:id])
  end
  
  def event_params
    params.require(:event).permit(:all_day, :start_at, :end_at, :title, :content, :vacation_set, :shifted_mode, :on_duty_staff)
  end
  #將時間格式切割成[年,月,日,時,分]或[年,月,日]
  def time_split(time)
    if time.split("T").length > 1
      return [time.split("-")[0].to_i,time.split("-")[1].to_i,time.split("-")[2].split("T")[0].to_i,time.split("T")[1].split(":")[0].to_i,time.split("T")[1].split(":")[1].to_i]
    elsif time.split(" ").length > 1
      return [time.split("-")[0].to_i,time.split("-")[1].to_i,time.split("-")[2].split(" ")[0].to_i,time.split(" ")[1].split(":")[0].to_i,time.split(" ")[1].split(":")[1].to_i]
    else
      return [time.split("-")[0].to_i,time.split("-")[1].to_i,time.split("-")[2].to_i]
    end
  end
    
  #依不同排班模式找出須排除的休假事件
  def holidays(shifted_mode)
    if shifted_mode == "循環例假"
      result = []
      search_events = Event.where(work_shift_id: params[:work_shift_id])
      search_events.each do |search_event|
        time_slice = time_split(search_event.start_at.to_formatted_s(:db))
        adjust_time_slice = time_split((DateTime.new(time_slice[0],time_slice[1],time_slice[2],time_slice[3],time_slice[4])+8.0/24).to_formatted_s(:db))
        adjust_date = Date.new(adjust_time_slice[0],adjust_time_slice[1],adjust_time_slice[2])
        if [0,6].include?(adjust_date.wday)
          result << [time_split(search_event.start_at.to_formatted_s(:db)),time_split(search_event.end_at.to_formatted_s(:db))]
        end
      end
    else
      result = Event.where(vacation_set: ["休假日","例假日","國定假日"], work_shift_id: params[:work_shift_id]).map{|e|
      [time_split(e.start_at.to_formatted_s(:db)),
        time_split(e.end_at.to_formatted_s(:db))] }
    end
    return result
  end 
    
  #找出循環工作排班模式下須排除的工作事件
  def work_titles(vacation_set)
    return Event.where(vacation_set: vacation_set, work_shift_id: params[:work_shift_id]).map{|e|
    [time_split(e.start_at.to_formatted_s(:db)),time_split(e.end_at.to_formatted_s(:db)), e.title] }
  end
    
  #檢驗排班時間是否已有排定休假
  def holiday_check(check_start,check_end,holidays)
    holiday_check = []
    holidays.each do |holiday|
      if check_end < (DateTime.new(holiday[0][0],holiday[0][1],holiday[0][2],holiday[0][3],holiday[0][4])+8.0/24) || check_start > (DateTime.new(holiday[1][0],holiday[1][1],holiday[1][2],holiday[1][3],holiday[1][4])+8.0/24)
        holiday_check << 0
      else
        holiday_check << 1
      end  
    end
    return holiday_check
  end
    
  #檢驗排班時間是否已有排定工作
  def work_title_check(check_start,check_end,work_titles)
    work_title_check = []
    work_titles.each do |work_title|
      if check_end < (DateTime.new(work_title[0][0],work_title[0][1],work_title[0][2],work_title[0][3],work_title[0][4])+8.0/24) || check_start > (DateTime.new(work_title[1][0],work_title[1][1],work_title[1][2],work_title[1][3],work_title[1][4])+8.0/24)
        work_title_check << 0
      else
        if params["event"]["title"]==work_title[2]
          work_title_check << 1
        else
          work_title_check << 0
        end
      end  
    end
    return work_title_check
  end

  def event_time_change(start_at,end_at)
    return Event.new(:all_day => params["event"]["all_day"], :start_at => start_at, :end_at => end_at, :title => params["event"]["title"], :content => params["event"]["content"], :vacation_set => params["event"]["vacation_set"], :on_duty_staff => params["event"]["on_duty_staff"], :shifted_mode => params["event"]["shifted_mode"], work_shift_id: params[:work_shift_id])
  end
end


