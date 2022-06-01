class ReviewsController < ApplicationController
  before_action :select_toilet, only: %i[new create index]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.toilet = @toilet

    if @review.save
      redirect_to toilet_path(@toilet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @reviews = Review.all
  end

  def destroy
    @review = Review.find(params[:id])
    @toilet = Toilet.find(@review[:toilet_id])

    @review.destroy
    redirect_to toilet_path(@toilet), status: :see_other
  end

  private

  def select_toilet
    @toilet = Toilet.find(params[:toilet_id])
  end

  def review_params
    params.require(:review).permit(
      :toilet_id,
      :rating,
      :comment,
      :baby,
      :accessible,
      :sink,
      :soap,
      :paper,
      :tampon,
      :bin,
      :hanger,
      :spacious,
      :clean,
      :gendered,
      :privacy,
      :urinal,
      :towel,
      :gratis,
      :current_user,
      photos: []
    )
  end
end
