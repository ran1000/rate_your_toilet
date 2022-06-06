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
    
    console.log(`https://api.mapbox.com/directions/v5/mapbox/walking/${this.userlng},${this.userlat};${this.markerlng},${this.markerlat}?access_token=${this.apiKeyValue}`)
    fetch(`https://api.mapbox.com/directions/v5/mapbox/walking/${this.userlng},${this.userlat};${this.markerlng},${this.markerlat}?access_token=${this.apiKeyValue}&steps=true`)
        .then(response => response.json())
        .then((data) => {this.#addRoute(data.routes[0].legs[0].steps)})

    this.#locateUser()
    this.#addMarkersToMap()
    this.#fitMapToMarkers()

  }

  #addRoute(waypoints) {

    if (waypoints !== undefined) {
      console.log(waypoints)
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

  #addMarkersToMap(){

    this.markersValue.forEach((marker) => {

      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
      this.markerlng = marker.lng
      this.markerlat = marker.lat


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
    this.map.on('load', () => {
      geolocate.trigger();
      geolocate.on('geolocate', (e) => {
        this.userlng = e.coords.longitude;
        this.userlat = e.coords.latitude
        console.log(`https://api.mapbox.com/directions/v5/mapbox/walking/${this.userlng},${this.userlat};${this.markerlng},${this.markerlat}?access_token=${this.apiKeyValue}`)
        fetch(`https://api.mapbox.com/directions/v5/mapbox/walking/${this.userlng},${this.userlat};${this.markerlng},${this.markerlat}?access_token=${this.apiKeyValue}&steps=true`)
            .then(response => response.json())
            .then((data) => {this.#addRoute(data.routes[0].legs[0].steps)})
      });

    });

  }


}


// "country_crossed": false,
//         "weight_name": "pedestrian",
//         "weight": 1416.442,
//         "duration": 1310.985,
//         "distance": 1894.372,
//         "legs": [
//         {
//         "via_waypoints": [],
//         "admins": [
//         {
//         "iso_3166_1_alpha3": "DEU",
//         "iso_3166_1": "DE"
//         }
//         ],
//         "weight": 1416.442,
//         "duration": 1310.985,
//         "steps": [],
//         "distance": 1894.372,
//         "summary": "Wilhelmstraße, Ebertstraße"
//         }
//         ],
//         "geometry": "gjn_IgivpAw@Pp@b]{g@jTxDr\\W@CZkNcAiB~BU_D"
//         }
//         ],
//         "waypoints": waypoints,
//         "code": "Ok",
//         "uuid": "45xUidILnfrtFGmypZD_JXtSntFDQTAS_UqLRcYnS8p_YTxaxabOSw=="
//         }
