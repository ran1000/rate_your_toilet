import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["btn", "map", "toilets"]

  connect() {
    console.log(this.btnTarget)
  }
  open() {
    this.toiletsTarget.classList.remove("d-none")
    this.mapTarget.classList.add("d-none")
  }
}
