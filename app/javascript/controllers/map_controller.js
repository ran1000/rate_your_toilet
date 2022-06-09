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
      center: [13.3913, 52.5073], // starting position [lng, lat]
      zoom: 15, // starting zoom
      pitch: 45
    });

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
      // const popup = new mapboxgl.Popup().setHTML(marker.info_window)

      const customMarker = document.createElement("div")
      customMarker.className = "marker"
      customMarker.style.backgroundImage = `url('${marker.image_url}')`
      customMarker.style.backgroundSize = "contain"
      customMarker.style.width = "25px"
      customMarker.style.height = "25px"
      customMarker.dataset.toilet_id = marker.toilet_id
      const toiletCards = document.querySelectorAll(".toilet-cards-sel")
      console.log(toiletCards)

      customMarker.addEventListener("click", (event) => {
        // console.log(event.target.dataset)
        const toiletCard = document.getElementById(event.target.dataset.toilet_id)
        console.log(toiletCard)
        console.log(toiletCards)
        toiletCards.forEach((card) => {
          card.classList.add("d-none");
          // card.classList.remove("show-card");
        })
        toiletCard.classList.toggle("d-none");

      })
      const closingTag = document.querySelectorAll(".closing-tag")
      closingTag.forEach((x) => {
        x.addEventListener("click", (event) => {
          const toiletCard = document.getElementById(event.target.dataset.toilet_id)
          toiletCards.forEach((card) => {
            card.classList.add("d-none");
          })
          toiletCard.classList.add("d-none")
        })
      })

      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        // .setPopup(popup)
        .addTo(this.map);
      this.markerlng = marker.lng
      this.markerlat = marker.lat
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))
    bounds.extend([this.userlng, this.userlat])
    // this.markersValue.forEach(marker => bounds.extend([ this.userlng,this.userlat ]))

    this.map.fitBounds(bounds, { padding: 70, maxZoom: 14, duration: 0 })
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
        this.map.setZoom(15);
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
