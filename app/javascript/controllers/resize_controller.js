import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="resize"
export default class extends Controller {
  static targets = ['input']

  connect() {
    this.inputTarget.style.height = `${this.inputTarget.scrollHeight}px`;
  }

  resizeInput() {
    this.inputTarget.style.height = '2rem';
    this.inputTarget.style.height = `${this.inputTarget.scrollHeight}px`;
  }
}
