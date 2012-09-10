class LineItemsController < ApplicationController

  def create
    @line_item = current_cart.add_product(Product.find(params[:product_id]))
    if @line_item.save
      redirect_to @line_item.cart
    end 
  end
end