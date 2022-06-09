// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AddressAutocompleteController from "./address_autocomplete_controller.js"
application.register("address-autocomplete", AddressAutocompleteController)

import HelloController from "./hello_controller.js"
application.register("hello", HelloController)

import MapController from "./map_controller.js"
application.register("map", MapController)

import ReviewsController from "./reviews_controller.js"
application.register("reviews", ReviewsController)

import ToiletsController from "./toilets_controller.js"
application.register("toilets", ToiletsController)

import UserCoordinatesController from "./user_coordinates_controller.js"
application.register("user-coordinates", UserCoordinatesController)
