class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]

  def new
    @user = User.find_by(id: params[:user_id])
    @review = Review.new
  end

  def create
    @user = User.find_by(id: params[:review][:user_id])
    @review = Review.create(reviews_params.merge(user_id: @user.id, reviewer_id: current_user.id))
    redirect_to user_path(@user)
  end

  def edit
    @review = Review.find_by(user_id: params[:id])
    if is_poster?
      @user = @review.user
    else
      render "/_unauthorized"
    end
  end

  def update
    if is_poster?
      @review.update_attributes(reviews_params)
      redirect_to user_path(@review.user)
    else
      render "/_unauthorized"
    end
  end

  def destroy
    if is_poster?
      @user = @review.user
      @review.destroy
      redirect_to user_path(@user)
    else
      render "/_unauthorized"
    end
  end

private

  def reviews_params
    params.require(:review).permit(:rating, :body, :user_id)
  end

  def set_review
    @review = Review.find_by(id: params[:id])
  end

  def is_poster?
    @review.reviewer == current_user
  end

end
