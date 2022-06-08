import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  connect() {
    let start_at = document.querySelector("#start_at");
    let end_at = document.querySelector("#end_at");
    let on_duties = document.querySelector("#on_duties");
    let vacations = document.querySelector("#vacations");
    let punchcards = document.querySelector("#punchcards");
    let search_results = document.querySelector("#search_results");
    on_duties.addEventListener("click", function () {
      let record = document.querySelector("table");
      if (record !== null) {
        record.remove();
      }
      Rails.ajax({
        type: "post",
        url: `/reports/on_duties/${start_at.value.replace(
          /:/g,
          ""
        )}/${end_at.value.replace(/:/g, "")}`,
        success: (data) => {
          var record = document.createElement("table");
          record.setAttribute("class", "w-full text-lg rounded-lg shadow-md");
          search_results.insertAdjacentElement("afterbegin", record);
          let record_head = document.createElement("thead");
          record_head.setAttribute("id", "record_head");
          record.insertAdjacentElement("beforeend", record_head);
          let record_content = document.createElement("tbody");
          record_content.setAttribute("id", "record_content");
          record.insertAdjacentElement("beforeend", record_content);
          if (data.message[0] == "") {
            let new_head = `<tr><span class="p-4 text-xl font-bold">班表彙總</span></tr><tr class="thead"><th class="tp">開始時間</th><th class="tp">結束時間</th><th class="tp">標題</th><th class="tp">內容</th></tr>`;
            record_head.insertAdjacentHTML("afterbegin", new_head);
            for (let i = 0; i < data.start_at.length; i++) {
              let new_row = `<tr><td class="tp">${
                data.start_at[i].split(".")[0]
              }</td><td class="tp">${
                data.end_at[i].split(".")[0]
              }</td><td class="tp">${data.title[i]}</td><td class="tp">${
                data.content[i]
              }</td></tr>`;
              record_content.insertAdjacentHTML("beforeend", new_row);
            }
          } else {
            record.insertAdjacentElement("beforebegin", new_title);
            let new_head = `<tr><span class="p-4 text-xl font-bold">班表彙總</span></tr><tr><th>開始時間</th><th>結束時間</th><th>標題</th><th>內容</th></tr>`;
            record_head.insertAdjacentHTML("afterbegin", new_head);
            let new_row = `<tr><td>無資料</td></tr>`;
            record_content.insertAdjacentHTML("afterbegin", new_row);
          }
        },
      });
    });

    vacations.addEventListener("click", function () {
      let record = document.querySelector("table");
      if (record !== null) {
        record.remove();
      }
      Rails.ajax({
        type: "post",
        url: `/reports/vacations/${start_at.value.replace(
          /:/g,
          ""
        )}/${end_at.value.replace(/:/g, "")}`,
        success: (data) => {
          let record = document.createElement("table");
          record.setAttribute("class", "w-full text-lg rounded-lg shadow-md");
          search_results.insertAdjacentElement("afterbegin", record);
          let record_head = document.createElement("thead");
          record_head.setAttribute("id", "record_head");
          record.insertAdjacentElement("beforeend", record_head);
          let record_content = document.createElement("tbody");
          record_content.setAttribute("id", "record_content");
          record.insertAdjacentElement("beforeend", record_content);
          if (data.message[0] == "") {
            let new_head = `<tr><span class="p-4 text-xl font-bold">請假紀錄</span></tr><tr class ="thead"><th class="tp">日期</th><th class="tp">假別</th><th class="tp">原因</th><th class="tp">時數</th><th class="tp">狀態</th></tr>`;
            record_head.insertAdjacentHTML("afterbegin", new_head);
            for (let i = 0; i < data.vacation_at.length; i++) {
              let new_row = `<tr><td class="tp">${data.vacation_at[i]}</td><td class="tp">${data.vacation_type[i]}</td><td class="tp">${data.reason[i]}</td><td class="tp">${data.hour[i]}</td><td class="tp">${data.status[i]}</td></tr>`;
              record_content.insertAdjacentHTML("beforeend", new_row);
            }
          } else {
            record.insertAdjacentElement("beforebegin", new_title);
            let new_head = `<tr><span class="p-4 text-xl font-bold">請假紀錄</span></tr><tr><th>日期</th><th>假別</th><th>原因</th><th>時數</th><th>狀態</th></tr>`;
            record_head.insertAdjacentHTML("afterbegin", new_head);
            let new_row = `<tr><td>無資料</td></tr>`;
            record_content.insertAdjacentHTML("afterbegin", new_row);
          }
        },
      });
    });

    punchcards.addEventListener("click", function () {
      let record = document.querySelector("table");
      if (record !== null) {
        record.remove();
      }
      Rails.ajax({
        type: "post",
        url: `/reports/punchcards/${start_at.value.replace(
          /:/g,
          ""
        )}/${end_at.value.replace(/:/g, "")}`,
        success: (data) => {
          let record = document.createElement("table");
          record.setAttribute("class", "w-full text-lg rounded-lg shadow-md");
          search_results.insertAdjacentElement("afterbegin", record);
          let record_head = document.createElement("thead");
          record_head.setAttribute("id", "record_head");
          record.insertAdjacentElement("beforeend", record_head);
          let record_content = document.createElement("tbody");
          record_content.setAttribute("id", "record_content");
          record.insertAdjacentElement("beforeend", record_content);
          if (data.message[0] == "") {
            let new_head = `<tr><span class="p-4 text-xl font-bold">打卡紀錄</span></tr><tr class = "thead"><th class="tp">上班打卡時間</th><th class="tp">下班打卡時間</th><th class="tp">體溫量測紀錄</th></tr>`;
            record_head.insertAdjacentHTML("afterbegin", new_head);
            for (let i = 0; i < data.punch_in_at.length; i++) {
              let new_row = `<tr><td class="tp">${
                data.punch_in_at[i].split(".")[0]
              }</td><td class="tp">${
                data.punch_out_at[i].split(".")[0]
              }</td><td class="tp">${data.body_temperature[i]}</td></tr>`;
              record_content.insertAdjacentHTML("beforeend", new_row);
            }
          } else {
            record.insertAdjacentElement("beforebegin", new_title);
            let new_head = `<tr><span class="p-4 text-xl font-bold">打卡紀錄</span></tr><tr><th>上班打卡時間</th><th>下班打卡時間</th><th>體溫量測紀錄</th></tr>`;
            record_head.insertAdjacentHTML("afterbegin", new_head);
            let new_row = `<tr><td>無資料</td></tr>`;
            record_content.insertAdjacentHTML("afterbegin", new_row);
          }
        },
      });
    });
  }
}
