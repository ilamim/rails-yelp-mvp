class ReviewsController < ApplicationController
  def new
    set_review_restaurant
    @review = Review.new
  end

  def create
    set_review_restaurant
    @review = Review.new(set_params)
    @review.restaurant = @restaurant
    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to restaurant_path(@review.restaurant), status: :see_other
  end

  private

  def set_params
    params.require(:review).permit(:content, :rating)
  end

  def set_review_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
