class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[splash]

  def splash
  end

  def dashboard
    @toilets = policy_scope(current_user.toilets)
    @favorites = policy_scope(current_user.favorites)
    @reviews = policy_scope(current_user.reviews)
    current_user.lat = params[:lat]
    current_user.lng = params[:lng]
    @toilets.map do |toilet|
      toilet.toilet_distance = (toilet.distance_from([current_user.lat, current_user.lng]).to_f)
    end
  end

  def categories
  end
end
