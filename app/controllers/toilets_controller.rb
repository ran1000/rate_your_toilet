class ToiletsController < ApplicationController
#
  before_action :select_toilet, only: %i[show edit update destroy]

  def show
  end

  def index
    @toilets = Toilet.all
  end

  def new
    @toilet = Toilet.new
  end

  def create
    @toilet = Toilet.new(toilet_params)
    @toilet.user = current_user
    if @toilet.save
      redirect_to toilet_path(@toilet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @toilet.update(toilet_params)
    redirect_to toilet_path(@toilet)
  end

  def destroy
    @toilet.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def select_toilet
    @toilet = Toilet.find(params[:id])
  end

  def toilet_params
    params.require(:toilet).permit(:name, :address)
  end
end
