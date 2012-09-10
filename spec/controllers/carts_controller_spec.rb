require 'spec_helper'

describe CartsController do
  let!(:cart) { create(:cart) }
  let!(:any_cart) { create(:cart) } # ensure @cart is always set to current_cart
  before { session[:cart_id] = cart.id } # set current_cart to cart

  describe "GET :show" do
    
    it "assign current_cart to @cart" do
      get :show, id: any_cart
      expect(assigns(:cart).id).to eq cart.id
    end
  end

  describe "DELETE :destroy" do

    it "assigns current_cart to @cart" do
      delete :destroy, id: any_cart
      expect(assigns(:cart).id).to eq session[:cart_id]
    end

    it "deletes cart" do
      expect{ delete :destroy, id: cart }.to change(Cart, :count).by(-1)
    end
  end

  # current_cart is an inherrited private method from application_controller
  describe "#current_cart method" do
    
    context "when there is no current_cart" do
      before { session[:cart_id] = nil }

      it "creates a new cart" do
        expect do
          post :show, id: any_cart
        end.to change(Cart, :count).by(1)
      end

      it "assigns current_cart.id to session[:cart_id]" do
        post :show, id: any_cart # creates a new cart
        expect(session[:cart_id]).to eq Cart.last.id
      end

      it "assigns the current_cart to @cart" do
        post :show, id: any_cart
        expect(assigns(:cart).id).to eq session[:cart_id]
      end
    end

    context "when there is a current_cart" do

      it "assigns the current_cart to @cart" do
        post :show, id: any_cart
        expect(assigns(:cart).id).to eq cart.id
      end
    end
  end
end