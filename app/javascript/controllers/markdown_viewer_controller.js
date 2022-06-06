import { Controller } from "stimulus";
import { marked } from "marked";

export default class extends Controller {
  initialize() {
    this.origContent = "";
  }

  connect() {
    this.origContent = this.element.textContent.trim();
    this.element.innerHTML = marked.parse(this.origContent);
  }

  disconnect() {
    this.element.textContent = this.origContent;
  }
}
