class LineItemsController < ApplicationController

  def create
    redirect_to store_path
    @cart = current_cart
    @product = Product.find(params[:product_id])
    # @line_item = @cart.add_product
    # if @line_item.save
      # redirect_to @line_item.cart, notice: 'Line item was successfully created.'
    # end 
  end
end
