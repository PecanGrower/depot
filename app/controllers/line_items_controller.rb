class LineItemsController < ApplicationController

  def create
    cart = current_cart
    product = Product.find(params[:product_id])
    @line_item = cart.line_items.build(product_id: product)
    redirect_to @line_item.cart if @line_item.save
  end
end
