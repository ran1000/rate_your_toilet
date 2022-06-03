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
      zoom: 12, // starting zoom
      pitch: 45
    });
    // this.jumpToUser()
    this.#locateUser()
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

  #addMarkersToMap(){
    this.markersValue.forEach((marker) => {
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

// vvvv CHAOS STARTS HERE !vvvv


// User Location By IP adress v -S
  #locateUser() {
    const geolocate = new mapboxgl.GeolocateControl({
      positionOptions: {
        enableHighAccuracy: true,
      },
      // When active the map will receive updates to the device's location as it changes.
      trackUserLocation: true,
      // Draw an arrow next to the location dot to indicate which direction the device is heading.
      showUserHeading: false,
    })
    this.map.addControl(geolocate)
  }
  // jumpToUser() {
  //   navigator.geolocation.getCurrentPosition((position) => {
  //     console.log(position.longitude, position.latitude)
  //     this.map.jumpTo({
  //       center: [position.coords.longitude, position.coords.latitude],
  //       zoom: 12,
  //       pitch: 45,

  //     })
  //   })
  // }
}
