class PagesController < ApplicationController
  # before_action :set_toilet, only: %i[routeto]
  skip_before_action :authenticate_user!, only: [:home, :routeto]

  def home
  end

  def dashboard
    @toilets = policy_scope(current_user.toilets)
    @favorites = policy_scope(current_user.favorites)
    @reviews = policy_scope(current_user.reviews)

    # @toilets = current_user.toilets
    # @favorites = current_user.favorites
  end

  def categories
  end

  def routeto
    # @review = Review.new
    # authorize @toilet
    # authorize @review

    # @pictures = []
    # @toilet.reviews.each do |review|
    #   review.photos.each do |photo|
    #     @pictures.push(photo)
    #   end
    # end
    # @markers = Toilet.where(id: @toilet.id).geocoded.map do |toilet|
    #   {
    #     lat: toilet.latitude,
    #     lng: toilet.longitude
    #   }
    # end
  end

  # private

  # def set_toilet
  #   @toilet = Toilet.find(params[:id])
  # end

  # def toilet_params
  #   params.require(:toilet).permit(:name, :address)
  # end

end
