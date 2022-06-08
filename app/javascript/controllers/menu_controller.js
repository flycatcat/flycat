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
import { useClickOutside } from 'stimulus-use'

export default class extends Controller {
  static targets = ["toggleable"]

  connect(){
    useClickOutside(this)
  }

  toggle(event){
      event.preventDefault();
      this.toggleableTarget.classList.toggle('hidden')
      
  }
}
<<<<<<< HEAD
>>>>>>> ee0b706 (docs(i18n): dropdown menu)
=======
>>>>>>> dbdf552 (docs(dropdown menu): js)
