<<<<<<< HEAD
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["toggleable"];

  toggle() {
    this.toggleableTarget.classList.toggle("hidden");
  }
}
=======
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["toggleable"]

  toggle(){
      this.toggleableTarget.classList.toggle('hidden')
  }
}
>>>>>>> ee0b706 (docs(i18n): dropdown menu)
