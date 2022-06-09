date_format = "%Y-%m-%d %H:%M%z"
json.extract! event, :id, :title, :start_at, :end_at, :content, :vacation_set
json.url work_shift_event_path(event.work_shift_id,event.id, format: :json)
json.show_url work_shift_event_path(event.work_shift_id,event.id, format: :html)
json.start event.start_at.strftime(date_format)
json.end event.end_at.strftime(date_format)
json.shifted_mode event.shifted_mode
json.allDay event.all_day
json.vacation_set event.vacation_set

