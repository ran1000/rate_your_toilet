import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["btn", "map", "toilets", "close", "filters", "popups"]

  connect() {
    let params = new URLSearchParams(window.location.search);
    console.log(params)
    let urlEnd = params.get('toilet_params')
    let anchor = urlEnd.split("?")[0]
    console.log(anchor)
    // Finds the corresponding element:
    const element = document.getElementById(anchor);
    const menu = document.querySelector(".horizontal-menu");
    if (element) {
      const leftPosition = element.offsetLeft;
      console.log(leftPosition)
      // This line actually takes us to the element:
      menu.scrollLeft = leftPosition - 180
    }
  }

  open() {
    this.toiletsTarget.classList.remove("d-none")
    this.mapTarget.classList.add("d-none")
    this.popupsTarget.classList.add("d-none")
    this.filtersTarget.classList.add("d-none")
  }
  close() {
    this.toiletsTarget.classList.add("d-none")
    this.filtersTarget.classList.remove("d-none")
    this.mapTarget.classList.remove("d-none")
    this.popupsTarget.classList.remove("d-none")
  }
}
