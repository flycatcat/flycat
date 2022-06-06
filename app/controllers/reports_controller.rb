class ReportsController < ApplicationController
  def index
  end
  def on_duties
    staff = Profile.where(user_id: current_user.id)
    work_shift_id = WorkShift.find_by(title: staff[0].work_shift_title).id
    events = Event.where("start_at >= ? AND end_at <= ? And work_shift_id = ?", params[:start_at], params[:end_at], work_shift_id)
    data = {start_at: [], end_at: [], title: [], content: [], message:[]}
    if events[0].nil?
        data[:message] << "無資料"
    else
      data[:message] << ""
      events.each do |event|
        if event.on_duty_staff.split(staff[0].staff_no+"_"+staff[0].name).length > 1
          data[:start_at] << event.start_at
          data[:end_at] << event.end_at
          data[:title] << event.title
          data[:content] << event.content
        end
      end
    end
    render json: data
  end

  def vacations
    records = Vacation.where("created_at >= ? AND created_at <= ? And user_id = ?", params[:start_at], params[:end_at], current_user.id)
    data = {vacation_at: [], vacation_type: [], reason: [], hour: [], status:[], message:[]}
    if records[0].nil?
      data[:message] << "無資料"
    else
      data[:message] << ""
      records.each do |record|
        data[:vacation_at] << record.vacation_at
        data[:vacation_type] << record.vacation_type
        data[:reason] << record.reason
        data[:hour] << record.hour
        data[:status] << record.status
      end
    end
    render json: data
  end

  def punchcards
    records = Punchcard.where("created_at >= ? AND created_at <= ? And user_id = ?", params[:start_at], params[:end_at], current_user.id)
    data = {punch_in_at: [], punch_out_at: [], body_temperature: [], message:[]}
    if records[0].nil?
      data[:message] << "無資料"
    else
      data[:message] << ""
      records.each do |record|
        data[:punch_in_at] << record.punch_in_at
        data[:punch_out_at] << record.punch_out_at
        data[:body_temperature] << record.body_temperature
      end
    end
    render json: data
  end

end

