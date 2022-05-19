import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="button-click"
export default class extends Controller {
  addClicked() {
    this.element.classList.add('clicked')
  }

  removeClicked() {
    this.element.classList.remove('clicked')
  }
}
