class ToiletsController < ApplicationController
  before_action :set_toilet, only: %i[show edit update destroy directions]
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    # @reviews = Review.where(urinal: true)
    # @toilets = Toilet.where(id: toilet_id)
    @toilets = policy_scope(Toilet.all)
    # @toilets = policy_scope(Toilet.reviews.where(urinal: true))
    @markers = @toilets.geocoded.map do |toilet|
      {
        lat: toilet.latitude,
        lng: toilet.longitude,
        toilet_id: toilet.id,
        # info_window: render_to_string(partial: "info_window", locals: {toilet: toilet}),
        image_url: helpers.asset_url("logo.png")
      }
    end
  end

  def show
    @review = Review.new
    authorize @toilet
    authorize @review

    @pictures = []
    @toilet.reviews.each do |review|
      review.photos.each do |photo|
        @pictures.push(photo)
      end
    end
    @markers = Toilet.where(id: @toilet.id).geocoded.map do |toilet|
      {
        lat: toilet.latitude,
        lng: toilet.longitude
      }
    end
  end

  def new
    @toilet = Toilet.new
    authorize @toilet
  end

  def create
    @toilet = Toilet.new(toilet_params)
    @toilet.user = current_user
    authorize @toilet
    if @toilet.save
      redirect_to toilet_path(@toilet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @toilet
  end

  def update
    authorize @toilet
    @toilet.update(toilet_params)
    redirect_to toilet_path(@toilet)
  end

  def destroy
    authorize @toilet
    @toilet.destroy
    redirect_to root_path, status: :see_other
  end

  def directions
    authorize @toilet
    @markers = Toilet.where(id: @toilet.id).geocoded.map do |toilet|
      {
        lat: toilet.latitude,
        lng: toilet.longitude
      }
    end
  end

  private

  def set_toilet
    @toilet = Toilet.find(params[:id])
  end

  def toilet_params
    params.require(:toilet).permit(:name, :address)
  end
end
