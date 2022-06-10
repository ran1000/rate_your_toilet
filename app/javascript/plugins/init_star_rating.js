import "jquery-bar-rating";
import $ from 'jquery';

const initStarRating = () => {
  console.log("starrating");
  $('#review_rating').barrating({
    theme: 'css-stars'
  });

};

export { initStarRating };
