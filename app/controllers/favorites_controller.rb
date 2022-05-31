class FavoritesController < ApplicationController
  before_action :select_toilet, only: %i[new create]

  def new
    @favorite = Favorite.new
  end

  def create
    @favorite = Favorite.new(favorite_params)
    @favorite.user = current_user
    @favorite.toilet = @toilet

    if @favorite.save
      redirect_to toilet_path(@toilet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @favorites = Favorite.all
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @toilet = Toilet.find(@review[:toilet_id])
    @favorite.destroy
    redirect_to toilet_path(@toilet), status: :see_other
  end

  private

  def favorite_params
    params.require(:favorite).permit(:user_id, :toilet_id)
  end

  def select_toilet
    @toilet = Toilet.find(params[:toilet_id])
  end
end
