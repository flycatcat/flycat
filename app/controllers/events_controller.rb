# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :find_event, only: %i[show edit update destroy]
  before_action :find_work_shift, except: [:destroy]

  def index
    start_date = params[:start]
    end_date = params[:end]
    work_shift_id = params[:work_shift_id]
    @events = Event.where('start_time >= ? AND end_time <= ? And work_shift_id = ?', start_date, end_date, work_shift_id)
  end

  def show; end

  def new
    @event = Event.new
  end

  def edit; end

  def create
    case params['event']['mode']
    when '一般'
      @event = Event.new(event_params.merge(work_shift_id: params[:work_shift_id]))
      if @event.save
        redirect_to setting_work_shift_path, notice: '新增成功!'
      else
        render :new
      end
    when '循環工作'
      holidays = holidays(%w[休假日 例假日 國定假日])
      work_titles = work_titles('工作日')
      index = -1
      fail_times = []
      format_date('start_time(1i)', 'start_time(2i)', 'start_time(3i)').upto(format_date('end_time(1i)', 'end_time(2i)', 'end_time(3i)')) do |date|
        index += 1
        if holidays.include?(date)
          fail_times[index] = 0
        elsif work_titles.include?(date.to_formatted_s(:db) + params['event']['title'])
          fail_times[index] = 0
        else
          event = event_time_change(format_datetime(date, 'start_time(4i)', 'start_time(5i)'), format_datetime(date, 'end_time(4i)', 'end_time(5i)'))
          fail_times[index] = if event.save
                                0
                              else
                                1
                              end
        end
      end
      if fail_times.sum.zero?
        redirect_to setting_work_shift_path, notice: '新增成功!'
      else
        redirect_to setting_work_shift_path, notice: '發生錯誤，請重新執行!'
      end
    when '循環例假'
      regular_holidays = holidays('例假日')
      index = -1
      fail_times = []
      format_date('start_time(1i)', 'start_time(2i)', 'start_time(3i)').upto(format_date('end_time(1i)', 'end_time(2i)', 'end_time(3i)')) do |date|
        index += 1
        if regular_holidays.include?(date)
          fail_times[index] = 0
        elsif [0, 6].include?(date.wday)
          event = event_time_change(format_datetime(date, 'start_time(4i)', 'start_time(5i)'), format_datetime(date, 'end_time(4i)', 'end_time(5i)'))
          fail_times[index] = if event.save
                                0
                              else
                                1
                              end
        else
          fail_times[index] = 0
        end
      end
      if fail_times.sum.zero?
        redirect_to setting_work_shift_path, notice: '新增成功!'
      else
        redirect_to setting_work_shift_path, notice: '發生錯誤，請重新執行!'
      end
    else
      events = Event.where('start_time >= ? AND end_time <= ? And work_shift_id = ?', format_date('start_time(1i)', 'start_time(2i)', 'start_time(3i)'),
                           format_date('end_time(1i)', 'end_time(2i)', 'end_time(3i)'), params[:work_shift_id])
      events.each(&:destroy)
      redirect_to setting_work_shift_path, notice: '刪除成功'
    end
  end

  def update
    if @event.update(event_params)
      redirect_to setting_work_shift_path, notice: '更新成功!'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to setting_work_shift_path, notice: '刪除成功'
  end

  private

  def find_work_shift
    @work_shift = WorkShift.find(params[:work_shift_id])
  end

  def find_event
    @event = Event.find(params[:event_id])
  end

  def event_params
    params.require(:event).permit(:all_day, :start_time, :end_time, :title, :content, :vacation_set, :mode)
  end

  def format_date(item1, item2, item3)
    Date.new(params['event'][item1].to_i, params['event'][item2].to_i, params['event'][item3].to_i)
  end

  def format_datetime(date, item1, item2)
    DateTime.new(date.to_formatted_s(:db).split('-')[0].to_i, date.to_formatted_s(:db).split('-')[1].to_i, date.to_formatted_s(:db).split('-')[2].to_i, params['event'][item1].to_i,
                 params['event'][item2].to_i).to_formatted_s(:db)
  end

  def holidays(vacation_set)
    Event.where(vacation_set: vacation_set, work_shift_id: params[:work_shift_id]).map do |e|
      Date.new(e.start_time.to_formatted_s(:db).split[0].split('-')[0].to_i, e.start_time.to_formatted_s(:db).split[0].split('-')[1].to_i, e.start_time.to_formatted_s(:db).split[0].split('-')[2].to_i)
    end
  end

  def work_titles(vacation_set)
    Event.where(vacation_set: vacation_set, work_shift_id: params[:work_shift_id]).map do |e|
      Date.new(e.start_time.to_formatted_s(:db).split[0].split('-')[0].to_i, e.start_time.to_formatted_s(:db).split[0].split('-')[1].to_i,
               e.start_time.to_formatted_s(:db).split[0].split('-')[2].to_i).to_formatted_s(:db) + e.title
    end
  end

  def event_time_change(start_time, end_time)
    Event.new(all_day: params['event']['all_day'], all_day: params['event']['all_day'], start_time: start_time, end_time: end_time, title: params['event']['title'],
              content: params['event']['content'], vacation_set: params['event']['vacation_set'], work_shift_id: params[:work_shift_id])
  end
end
