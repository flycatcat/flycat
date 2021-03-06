class ReportsController < ApplicationController
  def index
    authorize :report
  end
  def on_duties
    staff = Profile.where(user_id: current_user.id)
    data = {start_at: [], end_at: [], title: [], content: [], message:[]}
    data_check = []
    if staff[0].nil?
      data_check << 0
    else
      work_shift_id = WorkShift.find_by(title: staff[0].work_shift_title).id
      start_at = time_format(params[:start_at])
      end_at = time_format(params[:end_at])
      events = Event.where("start_at >= ? AND end_at <= ? And work_shift_id = ?", start_at, end_at, work_shift_id)
      if events[0].nil?
        data_check << 0
      else
        events.each do |event|
          if event.on_duty_staff == ""
            data_check << 0
          else 
            if event.on_duty_staff.split(" ").include?(staff[0].staff_no+"_"+staff[0].name)
              data_check << 1
              data[:start_at] << event.start_at
              data[:end_at] << event.end_at
              data[:title] << event.title
              data[:content] << event.content
            else
              data_check << 0
            end
          end
        end
      end
    end
    if data_check.sum >0
      data[:message] << ""
    else
      data[:message] << "無資料"
    end
    render json: data
  end

  def vacations
    start_at = time_format(params[:start_at])
    end_at = time_format(params[:end_at])
    records = Vacation.where("created_at >= ? AND created_at <= ? And user_id = ?", start_at, end_at, current_user.id)
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
    start_at = time_format(params[:start_at])
    end_at = time_format(params[:end_at])
    records = Punchcard.where("created_at >= ? AND created_at <= ? And user_id = ?", start_at, end_at, current_user.id)
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

  private
  def time_format(time)
    day = time.split("T")[0]
    hour = time.split("T")[1][0]+time.split("T")[1][1]
    min = time.split("T")[1][2]+time.split("T")[1][3]
    return day+" "+hour+":"+min
  end

end

