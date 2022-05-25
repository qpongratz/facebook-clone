import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = [ 'popup', 'toggle' ]

  togglePopup(){
    this.popupTarget.classList.toggle('hidden')
  }

  closePopup(){
    this.popupTarget.classList.add('hidden')
  }

  closePopupDelayed(){
    setTimeout(() => {
      if (this.popupTarget.contains(document.activeElement)) {
        return;
      } else {
        this.closePopup();
      };
    }, "50");
  }

  closeBackground(e) {
    if (e && (this.popupTarget.contains(e.target) || this.toggleTarget.contains(e.target))) {
      return
    }
    this.closePopup()
  }
}
