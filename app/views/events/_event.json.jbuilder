date_format = "%Y-%m-%d %H:%M%z"
json.extract! event, :id, :title
json.url event_path(event.work_shift_id,event.id, format: :json)
json.show_url event_path(event.work_shift_id,event.id, format: :html)
json.start event.start_time.strftime(date_format)
json.end event.end_time.strftime(date_format)
json.allDay event.all_day

