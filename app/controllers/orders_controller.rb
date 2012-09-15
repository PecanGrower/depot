class OrdersController < ApplicationController

  def new
    @cart = current_cart #cart display
    @order = Order.new
    if current_cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty"
    end
  end

  def create
    @order = Order.new(params[:order])
    @order.add_line_items_from_cart(current_cart)
    if @order.save
      OrderNotifier.received(@order).deliver
      redirect_to store_url, notice: "Thank you for your order."
    else
      @cart = current_cart #cart display
      render 'new'
    end
  end
end
