import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  // static targets = ["fav", "toi", "rev"]
  connect() {
    // Sections animation Dashboard
    // console.log(this.element)
    // console.log(this.favTarget)
    // console.log(this.toiTarget)
    // console.log(this.revTarget)
    // const dashFavorites = document.querySelector(".nav-dash-fav")
    // const dashToilets = document.querySelector(".nav-dash-toi")
    // const dashReviews = document.querySelector(".nav-dash-rev")
    // dashFavorites.addEventListener("click", (event) => {
    //   const sectionFavorites = document.getElementById("favorites")
    //   const dashboardSections = document.querySelectorAll(".dash-sections")
    //   dashboardSections.forEach((section) => {
    //     section.classList.add("d-none");
    //   })
    //   sectionFavorites.classList.toggle("d-none");
    // })
    // dashToilets.addEventListener("click", (event) => {
    //   const sectionToilets = document.getElementById("toilets")
    //   const dashboardSections = document.querySelectorAll(".dash-sections")
    //   dashboardSections.forEach((section) => {
    //     section.classList.add("d-none");
    //   })
    //   sectionToilets.classList.toggle("d-none");
    // })
    // dashReviews.addEventListener("click", (event) => {
    //   const sectionReviews = document.getElementById("reviews")
    //   const dashboardSections = document.querySelectorAll(".dash-sections")
    //   dashboardSections.forEach((section) => {
    //     section.classList.add("d-none");
    //   })
    //   sectionReviews.classList.toggle("d-none");
    // })

  }
}


    // Sections animation Dashboard (Vanilla JS)
    // const dashFavorites = document.querySelector(".nav-dash-fav")
    // const dashToilets = document.querySelector(".nav-dash-toi")
    // const dashReviews = document.querySelector(".nav-dash-rev")
    // dashFavorites.addEventListener("click", (event) => {
    //   const sectionFavorites = document.getElementById("favorites")
    //   const dashboardSections = document.querySelectorAll(".dash-sections")
    //   dashboardSections.forEach((section) => {
    //     section.classList.add("d-none");
    //   })
    //   sectionFavorites.classList.toggle("d-none");
    // })
    // dashToilets.addEventListener("click", (event) => {
    //   const sectionToilets = document.getElementById("toilets")
    //   const dashboardSections = document.querySelectorAll(".dash-sections")
    //   dashboardSections.forEach((section) => {
    //     section.classList.add("d-none");
    //   })
    //   sectionToilets.classList.toggle("d-none");
    // })
    // dashReviews.addEventListener("click", (event) => {
    //   const sectionReviews = document.getElementById("reviews")
    //   const dashboardSections = document.querySelectorAll(".dash-sections")
    //   dashboardSections.forEach((section) => {
    //     section.classList.add("d-none");
    //   })
    //   sectionReviews.classList.toggle("d-none");
    // })
