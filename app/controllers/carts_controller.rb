class CartsController < ApplicationController

  def show
    @cart = current_cart
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    redirect_to store_url, notice: 'Your cart is currently empty'
  end
end