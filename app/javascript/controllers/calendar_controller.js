import { Controller } from "stimulus";
import { Calendar } from "@fullcalendar/core";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import interactionPlugin from "@fullcalendar/interaction";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["calendar", "modal", "start_at", "end_at"];

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

        let start_at = document.querySelector("#event_start_at");
        let end_at = document.querySelector("#event_end_at");
        start_at.value = selected_date.toISOString().split("T")[0] + "T08:00";
        end_at.value = selected_date.toISOString().split("T")[0] + "T18:00";
      },
      eventClick: function (info) {
        info.jsEvent.preventDefault();
        Turbolinks.visit(info.event.extendedProps.show_url);
      },
      eventDrop: function (info) {
        let data = _this.data(info);
        if (data["event[end_at]"] === null) {
          let start_split = String(data["event[start_at]"]).split(" ");
          data["event[end_at]"] =
            start_split[0] +
            " " +
            start_split[1] +
            " " +
            String(Number(start_split[2]) + 1) +
            " " +
            start_split[3] +
            " " +
            start_split[4] +
            " " +
            start_split[5] +
            " " +
            start_split[6];
        }
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

    let shifted_list = document.querySelector("#shifted_list");
    let on_duty_staffs = document
      .querySelector("#event_on_duty_staff")
      .value.split(" ");
    if (on_duty_staffs.length != 0) {
      for (let i = 0; i < on_duty_staffs.length; i++) {
        if (on_duty_staffs[i] != "") {
          let new_on_duty = document.createElement("button");
          new_on_duty.setAttribute("class", "on_duty staff-btn");
          new_on_duty.textContent = on_duty_staffs[i];
          shifted_list.insertAdjacentElement("afterbegin", new_on_duty);
          new_on_duty.addEventListener("click", function () {
            new_on_duty.remove();
          });
        }
      }
    }
    let staff_list = document.querySelector("#staff_list");
    staff_list.addEventListener("change", function () {
      let on_duty = document.querySelectorAll(".on_duty");
      if (on_duty.length == 0) {
        let new_on_duty = document.createElement("button");
        new_on_duty.setAttribute("class", "on_duty staff-btn");
        new_on_duty.textContent = staff_list.value;
        staff_list.value = "請選擇";
        shifted_list.insertAdjacentElement("afterbegin", new_on_duty);
        new_on_duty.addEventListener("click", function () {
          new_on_duty.remove();
        });
      } else {
        let data_verified = [];
        let sum_data_verified = 0;
        for (let i = 0; i < on_duty.length; i++) {
          if (on_duty[i].textContent == staff_list.value) {
            data_verified[i] = 1;
            sum_data_verified = sum_data_verified + data_verified[i];
          } else {
            data_verified[i] = 0;
            sum_data_verified = sum_data_verified + data_verified[i];
          }
          on_duty[i].addEventListener("click", function () {
            on_duty[i].remove();
          });
        }
        if (sum_data_verified == 0) {
          let new_on_duty = document.createElement("button");
          new_on_duty.setAttribute("class", "on_duty staff-btn");
          new_on_duty.textContent = staff_list.value;
          staff_list.value = "請選擇";
          shifted_list.insertAdjacentElement("afterbegin", new_on_duty);
          new_on_duty.addEventListener("click", function () {
            new_on_duty.remove();
          });
        } else {
          staff_list.value = "請選擇";
        }
      }
    });
    let btn = document.querySelector(".btn");
    btn.addEventListener("click", function () {
      let on_duty = document.querySelectorAll(".on_duty");
      let on_duty_staff = document.querySelector("#event_on_duty_staff");
      let accum_staff = "";
      for (let i = 0; i < on_duty.length; i++) {
        accum_staff = accum_staff + " " + on_duty[i].textContent;
      }
      on_duty_staff.value = accum_staff;
    });
  }

  data(info) {
    return {
      "event[start_at]": info.event.start,
      "event[end_at]": info.event.end,
    };
  }
}
