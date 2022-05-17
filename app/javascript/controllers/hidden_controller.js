import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-hidden"
export default class extends Controller {
  static targets = [ 'display', 'clear' ]

  toggle() {
    this.displayTarget.classList.toggle('hidden');
    this.removeChildren(this.clearTarget);
  }

  removeChildren(parent) {
    while (parent.firstChild) {
      parent.removeChild(parent.firstChild);
    }
  }
}
