class ReviewsController < ApplicationController
  before_action :set_toilet, only: %i[new edit show update create index]
  before_action :set_review, only: %i[show edit update]

  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    @reviews = policy_scope(Review.all)
    @reviews = @toilet.reviews
    # authorize @toilet
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

  def edit
    authorize @review
  end

  def update
    authorize @review
    @review.update(review_params)
    redirect_to toilet_path(@toilet)
  end

  def destroy
    @review = Review.find(params[:id])
    @toilet = Toilet.find(@review[:toilet_id])
    authorize @review
    @review.destroy
    redirect_to dashboard_path, status: :see_other
  end

  private

  def set_toilet
    @toilet = Toilet.find(params[:toilet_id])
  end

  def set_review
    @review = Review.find(params[:id])
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
