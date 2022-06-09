import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  connect() {
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
}
