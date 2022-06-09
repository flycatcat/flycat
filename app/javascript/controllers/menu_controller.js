import { Controller } from "stimulus"
import { useClickOutside } from 'stimulus-use'

export default class extends Controller {
  static targets = ["toggleable"]

  
  toggle(){
    this.toggleableTarget.classList.toggle('hidden')
  }
  
  connect() {
    useClickOutside(this)
  }
  
  clickOutside(event) {
    if (!this.toggleableTarget.classList.contains('hidden')){
      event.preventDefault()
      this.toggleableTarget.classList.add('hidden')
    }
  }
}
