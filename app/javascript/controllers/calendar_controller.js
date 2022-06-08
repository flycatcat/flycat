import { Controller } from "stimulus";
import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import interactionPlugin from "@fullcalendar/interaction";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["calendar", "modal", "start_time", "end_time"];

  connect() {
    let _this = this;
    let link = String(location.href).split("/");
    let calendar = new Calendar(this.calendarTarget, {
      events: "/" + link[3] + "/" + link[4] + "/events.json",
      editable: true,
      navLinks: true,
      headerToolbar: { center: "dayGridMonth,timeGridWeek,timeGridDay" },
      plugins: [dayGridPlugin, timeGridPlugin, interactionPlugin],
      navLinkDayClick: function (date) {
        _this.modalTarget.style.display = "block";
        let selected_date = new Date(
          Number(date.toISOString().split("-")[0]),
          Number(date.toISOString().split("-")[1]) - 1,
          Number(date.toISOString().split("-")[2].split("T")[0]) + 2
        );
        let start_time = [
          document.querySelector("#event_start_time_1i"),
          document.querySelector("#event_start_time_2i"),
          document.querySelector("#event_start_time_3i"),
        ];

        let end_time = [
          document.querySelector("#event_end_time_1i"),
          document.querySelector("#event_end_time_2i"),
          document.querySelector("#event_end_time_3i"),
        ];

        let selected_date_slice = [
          Number(selected_date.toISOString().split("-")[0]),
          Number(selected_date.toISOString().split("-")[1]),
          Number(selected_date.toISOString().split("-")[2].split("T")[0]),
        ];

        for (let m = 0; m < start_time.length; m++) {
          for (let i = 0; i < start_time[m].length; i++) {
            if (selected_date_slice[m] == start_time[m].options[i].value) {
              start_time[m].options[i].selected = true;
              end_time[m].options[i].selected = true;
              break;
            }
          }
        }
      },
      eventClick: function (info) {
        info.jsEvent.preventDefault();
        Turbolinks.visit(info.event.extendedProps.show_url);
      },
      eventDrop: function (info) {
        let data = _this.data(info);
        Rails.ajax({
          type: "PATCH",
          url: info.event.url,
          data: new URLSearchParams(data).toString(),
        });
      },
      eventResize: function (info) {
        let data = _this.data(info);
        Rails.ajax({
          type: "PATCH",
          url: info.event.url,
          data: new URLSearchParams(data).toString(),
        });
      },
    });
    calendar.render();
  }

  data(info) {
    return {
      "event[start_time]": info.event.start,
      "event[end_time]": info.event.end,
    };
  }
}
