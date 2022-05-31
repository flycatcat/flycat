import { Controller } from "stimulus";
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = ["read", "unread", "readCount", "unreadCount"];

  connect() {
    if (this.element.dataset.read === "true") {
      this.readTarget.style.display = "none";
    } else {
      this.unreadTarget.style.display = "none";
    }
  }

  read(e) {
    e.preventDefault();
    const bulletinID = this.element.dataset.bulletinId;

    Rails.ajax({
      type: "post",
      url: `/api/v1/bulletins/${bulletinID}/read`,
      success: (data) => {
        if (data.message === "added") {
          this.readTarget.style.display = "none";
          this.unreadTarget.style.display = "block";
          this.unreadTarget.style.color = "text-yellow-500";
          this.unreadCountTarget.innerHTML = data.count;
        }
      },
    });
  }

  unread(e) {
    e.preventDefault();
    const bulletinID = this.element.dataset.bulletinId;

    Rails.ajax({
      type: "delete",
      url: `/api/v1/bulletins/${bulletinID}/unread`,
      success: (data) => {
        if (data.message === "removed") {
          this.readTarget.style.display = "block";
          this.readTarget.style.color = "text-yellow-300";
          this.readCountTarget.innerHTML = data.count;
          this.unreadTarget.style.display = "none";
        }
      },
    });
  }
}
