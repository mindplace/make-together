class ReviewsController < ApplicationController
  def new
    @user = User.find_by(id: params[:user_id])
    @review = Review.new
  end

  def create
    @review = Review.create(reviews_params)
    @user = User.find_by(id: params[:review][:user_id])
    @user.reviews << @review
    redirect_to user_path(@user)
  end

  def edit
    @review = Review.find_by(id: params[:id])
    @user = User.find_by(id: @review.user_id)
  end


  def update
      @review = Review.find_by(id: params[:id])
    @user = User.find_by(id: @review.user_id)
    @review.update_attributes(reviews_params)
    redirect_to user_path(@user)

  end

private
  def reviews_params
    params.require(:review).permit(:rating, :body, :user_id)
  end

end
