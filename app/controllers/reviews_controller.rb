class ReviewsController < ApplicationController
  before_action :select_toilet, only: %i[new create index]
  skip_before_action :authenticate_user!, only: %i[new show index]

  def index
    @reviews = policy_scope(Review.all)
  end

  def show
    @review = Review.find(params[:id])
    authorize @review
  end

  def new
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.toilet = @toilet
    authorize @review
    if @review.save
      redirect_to toilet_path(@toilet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @toilet = Toilet.find(@review[:toilet_id])
    authorize @review
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
      :current_user
    )
  end
end
