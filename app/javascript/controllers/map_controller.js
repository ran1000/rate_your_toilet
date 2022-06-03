import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element, // container ID
      style: "mapbox://styles/mapbox/streets-v11", // style URL
      center: [13.4050, 52.5200], // starting position [lng, lat]
      zoom: 1 // starting zoom
    });
    this.#addControl()
    this.#addMarkersToMap()
    this.#fitMapToMarkers()

  }

  #addMarkersToMap(){
    this.markersValue.forEach((marker) => {
      console.log(marker)
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    })
  }


  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 150 })
  }
// User Location By IP adress v -S
  #addControl() {
   this.map.addControl(new mapboxgl.GeolocateControl({
      positionOptions: {
        enableHighAccuracy: true
      },
      // When active the map will receive updates to the device's location as it changes.
      trackUserLocation: true,
      // Draw an arrow next to the location dot to indicate which direction the device is heading.
      showUserHeading: true

    }))
  }
}
