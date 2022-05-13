import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-hidden"
export default class extends Controller {
  static targets = [ 'display' ]

  toggle() {
    this.displayTarget.classList.toggle('hidden')
  }
}
