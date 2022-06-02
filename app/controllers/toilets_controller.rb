class ToiletsController < ApplicationController
  before_action :set_toilet, only: %i[show edit update destroy favorite]
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    @toilets = policy_scope(Toilet.all)
  end

  def show
    @review = Review.new
    authorize @toilet
    authorize @review
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

  # def favorite
  #   Favorite.create(user_id: current_user.id, toilet_id: @toilet.id)
  #   redirect_to toilet_path(@toilet)
  # end

  # def favorite_destroy
  #   Favorite.destroy(user_id: current_user.id, toilet_id: @toilet.id)
  #   redirect_to toilet_path(@toilet), status: :see_other
  # end

  private

  def set_toilet
    @toilet = Toilet.find(params[:id])
  end

  def toilet_params
    params.require(:toilet).permit(:name, :address)
  end
end
