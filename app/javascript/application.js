// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"

// Rating System
import { initStarRating } from './plugins/init_star_rating';
initStarRating();


// Sections animation Dashboard (Vanilla JS)
// const dashFavorites = document.querySelector(".nav-dash-fav")
// const dashToilets = document.querySelector(".nav-dash-toi")
// const dashReviews = document.querySelector(".nav-dash-rev")
// const sectionFavorites = document.getElementById("favorites")
// const dashboardSections = document.querySelectorAll(".dash-sections")
// const sectionToilets = document.getElementById("toilets")
// const sectionReviews = document.getElementById("reviews")

// dashFavorites.addEventListener("click", (event) => {
//   event.preventDefault
//   console.log("favourites")
//   dashboardSections.forEach((section) => {
//     section.classList.add("d-none");
//   })
//   sectionFavorites.classList.toggle("d-none");
// })
// dashToilets.addEventListener("click", (event) => {
//   event.preventDefault
//   console.log("toilets")
//   dashboardSections.forEach((section) => {
//     section.classList.add("d-none");
//   })
//   sectionToilets.classList.toggle("d-none");
// })
// dashReviews.addEventListener("click", (event) => {
//   event.preventDefault
//   console.log("reviews")
//   dashboardSections.forEach((section) => {
//     section.classList.add("d-none");
//   })
//   sectionReviews.classList.toggle("d-none");
// })
