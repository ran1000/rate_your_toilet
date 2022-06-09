import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["btn", "map", "toilets", "close", "filters"]

  connect() {
    // console.log(this.btnTarget)
  }
  open() {
    this.toiletsTarget.classList.remove("d-none")
    this.mapTarget.classList.add("d-none")
    this.filtersTarget.classList.add("d-none")
  }
  close() {
    this.toiletsTarget.classList.add("d-none")
    this.filtersTarget.classList.remove("d-none")
    this.mapTarget.classList.remove("d-none")
  }
}
