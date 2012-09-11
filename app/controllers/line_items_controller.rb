class LineItemsController < ApplicationController

  def create
    @cart = current_cart
    @line_item = @cart.add_product(Product.find(params[:product_id]))
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_url }
        format.js
      end 
    end
  end

  def destroy
    @line_item = current_cart.line_items.find_by_id(params[:id])
    @line_item.destroy
    redirect_to current_cart
  end
end