import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link"]
  connect() {

    navigator.geolocation.getCurrentPosition((position) => {

      this.linkTargets.forEach((l) => {
        l.href = `${l.href}?lat=${position.coords.latitude}&lng=${position.coords.longitude}`
      })
    });

  }
}
