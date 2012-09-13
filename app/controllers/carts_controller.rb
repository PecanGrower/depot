class CartsController < ApplicationController

  def show
    @cart = current_cart
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to store_url }
      format.js
    end
  end
end