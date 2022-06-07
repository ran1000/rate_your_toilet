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
      center: [4.4050, 52.5200], // starting position [lng, lat]
      zoom: 14, // starting zoom
      pitch: 45
    });

    // console.log(`https://api.mapbox.com/directions/v5/mapbox/walking/${this.userlng},${this.userlat};${this.markerlng},${this.markerlat}?access_token=${this.apiKeyValue}`)
    // fetch(`https://api.mapbox.com/directions/v5/mapbox/walking/${this.userlng},${this.userlat};${this.markerlng},${this.markerlat}?access_token=${this.apiKeyValue}&steps=true`)
    //     .then(response => response.json())
    //     .then((data) => {this.#addRoute(data.routes[0].legs[0].steps)})

    this.#locateUser()
    this.#addMarkersToMap()
    this.#fitMapToMarkers()

  }

  #addRoute(waypoints) {

    if (waypoints !== undefined) {

      // this.map.on('load', () => {
      this.map.addSource('path', {
        'type': 'geojson',
        'data': {
          'type': 'Feature',
          'properties': {},
          'geometry': {
            'type': 'LineString',
            "coordinates": waypoints.map(waypoint => waypoint.intersections[0].location),
          }
        }
      });
      this.map.addLayer({
        'id': 'path',
        'type': 'line',
        'source': 'path',
        'layout': {
          'line-join': 'round',
          'line-cap': 'round'
        },
        'paint': {
          'line-color': '#3ba5e3',
          'line-width': 8
        }
      });
      // })
    }
  }

  #addMarkersToMap() {

    this.markersValue.forEach((marker) => {

      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map)
      this.markerlng = marker.lng
      this.markerlat = marker.lat


    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))
    // this.markersValue.forEach(marker => bounds.extend([ this.userlng,this.userlat ]))

    this.map.fitBounds(bounds, { padding: 70, maxZoom: 14, duration: 150 })
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
      options: {

      }

    })
    this.map.addControl(geolocate)
    this.map.on('load', () => {
      geolocate.trigger();
      geolocate.on('geolocate', (e) => {
        this.userlng = e.coords.longitude;
        this.userlat = e.coords.latitude;
        this.map.setZoom(14);
        this.map.easeTo(true);
        this.#fitMapToMarkers();

        if (!isNaN(parseInt(this.element.baseURI.split("/")[this.element.baseURI.split("/").length - 1])) || (this.element.baseURI.includes("directions"))) {
          fetch(`https://api.mapbox.com/directions/v5/mapbox/walking/${this.userlng},${this.userlat};${this.markerlng},${this.markerlat}?access_token=${this.apiKeyValue}&steps=true`)
            .then(response => response.json())
            .then((data) => { this.#addRoute(data.routes[0].legs[0].steps) })
        }
      });

    });

  }


}

