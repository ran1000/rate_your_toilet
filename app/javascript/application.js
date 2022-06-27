// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import $ from 'jquery';

// Rating System
import { initStarRating } from './plugins/init_star_rating';
window.$ = $
window.initStarRating = initStarRating;
initStarRating();
