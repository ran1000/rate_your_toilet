class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :routeto]

  def splash
  end

  # def home

  # end

  def dashboard
    @toilets = policy_scope(current_user.toilets)
    @favorites = policy_scope(current_user.favorites)
    @reviews = policy_scope(current_user.reviews)
    current_user.lat = params[:lat]
    current_user.lng = params[:lng]
    @toilets.map do |toilet|
      toilet.toilet_distance = (toilet.distance_from([current_user.lat, current_user.lng]).to_f)
    end
    # @toilets = current_user.toilets
    # @favorites = current_user.favorites
  end

  def categories
  end
end
