class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]

  def new
    if logged_in?
      @user = User.find_by(id: params[:user_id])
      @review = Review.new
      if request.xhr?
        render :_form, layout: false
      end
    else
      redirect_to user_path(@user)
    end
  end

  def create
    @user = User.find_by(id: params[:review][:user_id])
    @review = Review.new(reviews_params.merge(user_id: @user.id, reviewer_id: current_user.id))
    if @review.save
      if request.xhr?
        render :_individual_review, layout: false, locals: {review: @review}
      else
        redirect_to user_path(@user)
      end
    else
      render :_form, layout: false, locals: {review: @review}
    end
  end

  def edit
    @review = Review.find_by(id: params[:id])
    @user = @review.user
    if is_poster?
      if request.xhr?
        render :_form, layout: false, locals: {review: @review}
      else
        redirect_to edit_review_path(@review)
      end
    else
      redirect_to user_path(@review.user)
    end
  end

  def update
    if is_poster?
      @review.update_attributes(reviews_params)
      if request.xhr?
        render :_individual_review, layout: false, locals: {review: @review}
      else
        redirect_to user_path(@review.user)
      end
    else
      render :_form, layout: false, locals: {review: @review}
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
