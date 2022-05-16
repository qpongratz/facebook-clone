import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="focus"
export default class extends Controller {
  static targets = [ 'input' ]

  focusInput() {
    this.inputTarget.focus();
    this.inputTarget.scrollIntoView({behavior: 'smooth', block: 'center'})
  }
}
