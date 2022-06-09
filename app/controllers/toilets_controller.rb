class ToiletsController < ApplicationController
  before_action :set_toilet, only: %i[show edit update destroy directions]
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    unless params[:lat] == nil || params[:lng] == nil
      current_user.lat = params[:lat]
      current_user.lng = params[:lng]
      current_user.update(lat: params[:lat], lng: params[:lng])
    end
    if params[:lat] == nil && current_user.lat.nil?
      @toilets = policy_scope(Toilet)
    else
      @toilets = policy_scope(Toilet.near([current_user.lat, current_user.lng], 0.1, units: :km))
      @toilets.map do |toilet|
        toilet.toilet_distance = (toilet.distance_from([current_user.lat, current_user.lng]))
      end
      raise
      # raise
    end

    if params[:toilet_params] == "baby"
      @toilets = @toilets.select { |t| t.baby_friendly? }

    elsif params[:toilet_params] == "period"
      @toilets = @toilets.select { |t| t.period_friendly? }


    elsif params[:toilet_params] == "show_all"
      @toilets

    elsif params[:toilet_params] == "accessible"
      @toilets = @toilets.select { |t| t.accessible? }

    elsif params[:toilet_params] == "urinal"
      @toilets = @toilets.select { |t| t.urinal? }

    elsif params[:toilet_params] == "stall"
      @toilets = @toilets.select { |t| t.stall? }

    elsif params[:toilet_params] == "easy_read"
      @toilets = @toilets.select { |t| t.easy? }

    elsif params[:toilet_params] == "changing_room"
      @toilets = @toilets.select { |t| t.changing_room? }
    end

    @toilets = @toilets.select { |t| t.geocoded? }
    @markers = @toilets.map do |toilet|
      {
        lat: toilet.latitude,
        lng: toilet.longitude,
        toilet_id: toilet.id,
        # info_window: render_to_string(partial: "info_window", locals: {toilet: toilet}),
        image_url: helpers.asset_url("marker_pic.svg")
      }
    end
    @toilets = @toilets.sort_by(&:toilet_distance) unless params[:lat] == nil || params[:lng] == nil
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

    @tag_list = []
    @toilet.baby_friendly? ? @tag_list.push("Baby friendly") : nil
    @toilet.period_friendly? ? @tag_list.push("Period friendly") : nil
    @toilet.accessible? ? @tag_list.push("Accessible") : nil
    @toilet.urinal? ? @tag_list.push("Urinal") : nil
    @toilet.stall? ? @tag_list.push("Stall") : nil
    @toilet.easy? ? @tag_list.push("Easy ") : nil
    @toilet.changing_room? ? @tag_list.push("Changing Room ") : nil

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
        lng: toilet.longitude,
        image_url: helpers.asset_url("marker_pic.svg")
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
