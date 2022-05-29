import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-hidden"
export default class extends Controller {
  static targets = [ 'display', 'clear', 'hide' ]

  toggle() {
    this.displayTarget.classList.toggle('hidden');
    this.removeChildren(this.clearTarget);
    this.hideTarget.classList.toggle('hidden')
  }

  removeChildren(parent) {
    while (parent.firstChild) {
      parent.removeChild(parent.firstChild);
    }
  }
}
