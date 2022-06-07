class ToiletsController < ApplicationController
  before_action :set_toilet, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    @toilets = policy_scope(Toilet.all)

    if params[:toilet_params] == "baby"
      @toilets = @toilets.select { |t| t.baby_friendly? }
    elsif params[:toilet_params] == "period"
      @toilets = @toilets.select { |t| t.period_friendly? }
    elsif params[:toilet_params] == "accessible"
      @toilets = @toilets.select { |t| t.accessible? }
    elsif params[:toilet_params] == "urinal"
      @toilets = @toilets.select { |t| t.urinal? }
    elsif params[:toilet_params] == "stall"
      @toilets = @toilets.select { |t| t.stall? }
    end

    if @toilets.length > 1
      @markers = @toilets.geocoded.map do |toilet|
        {
          lat: toilet.latitude,
          lng: toilet.longitude
        }
      end
    else
      @markers =
        [{
          lat: @toilets[0].latitude,
          lng: @toilets[0].longitude
        }]
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

  # def baby_friendly
  #   toilet.reviews.where(reviews(reviews: {baby: true}).count)
  # end

  private

  def set_toilet
    @toilet = Toilet.find(params[:id])
  end

  def toilet_params
    params.require(:toilet).permit(:name, :address)
  end

end
