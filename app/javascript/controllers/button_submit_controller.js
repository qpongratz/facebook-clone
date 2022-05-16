import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="button-submit"
export default class extends Controller {
  static targets = [ 'button' ]

  submitOnReturn(e){
    if (e.keyCode == 13 && !e.shiftKey){
      e.preventDefault();
      e.stopPropagation();
      this.buttonTarget.click();
    }
  }
}
