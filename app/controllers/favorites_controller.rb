class FavoritesController < ApplicationController
  before_action :select_toilet, only: %i[create]

  def index
    if current_user
      @favorites = policy_scope(current_user.favorites.all)
    else
      @favorites = []
    end
  end

  def create
    @favorite = current_user.favorites.new(favorite_params)
    @favorite.user = current_user
    @toilet = @favorite.toilet
    authorize @favorite
    if @favorite.save
      redirect_to toilet_path(@toilet)
    else
      flash[:notice] = @favorite.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    toilet = @favorite.toilet
    authorize @favorite
    @favorite.destroy
    redirect_to toilet_path(toilet), status: :see_other
  end

  private

  def favorite_params
    params.require(:favorite).permit(:toilet_id, :current_user)
  end

  def select_toilet
    @toilet = Toilet.find(params[:toilet_id])
  end
end
