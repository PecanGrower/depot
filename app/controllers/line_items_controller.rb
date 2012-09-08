class LineItemsController < ApplicationController

  def create
    @cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = @cart.line_items.build(product_id: product.id)
    if @line_item.save
      redirect_to @line_item.cart, notice: 'Line item was successfully created.'
    end 
  end
end
