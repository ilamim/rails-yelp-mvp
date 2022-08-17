class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
  end

  def show
    set_restaurant
    @reviews = @restaurant.reviews
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.create(set_params)
    if @restaurant.save
      redirect_to restaurant_path(@restaurant), notice: "Restaurant created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_params
    params.require(:restaurant).permit(:name, :address, :phone_number, :category)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
