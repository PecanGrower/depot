require 'spec_helper'

describe StoreController do

  describe ":index" do
    
    it "assigns all Products ordered by :title to @products" do
      get :index
      expect(assigns(:products)).to eq Product.order(:title)
    end

    it "assigns current_cart to @cart" do
      cart = create(:cart)
      session[:cart_id] = cart.id
      get :index
      expect(assigns(:cart)).to eq cart
    end
  end
end