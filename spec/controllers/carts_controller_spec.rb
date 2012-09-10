require 'spec_helper'

describe CartsController do

  describe "DELETE :destroy" do
    let!(:cart) { create(:cart) }
    before { session[:cart_id] = cart.id }

    it "assigns current_cart to @cart" do
      delete :destroy, id: cart
      expect(assigns(:cart).id).to eq session[:cart_id]
    end

    it "deletes cart" do
      expect{ delete :destroy, id: cart }.to change(Cart, :count).by(-1)
    end
  end

  describe "#current_cart method" do
    # current_cart is an inherrited private method from application_controller
    
    context "when there is no current_cart" do
      before { session[:cart_id] = nil }

      it "creates a new cart" do
        expect do
          post :show, id: 1
        end.to change(Cart, :count).by(1)
      end

      it "assigns current_cart.id to session[:cart_id]" do
        post :show, id: 1
        expect(session[:cart_id]).to eq Cart.last.id
      end

      it "assigns the current_cart to @cart" do
        post :show, id: 1
        expect(assigns(:cart).id).to eq session[:cart_id]
      end
    end

    context "when there is a current_cart" do
      let(:cart) { create(:cart) }
      before { session[:cart_id] = cart.id }

      it "assigns the current_cart to @cart" do
        post :show, id: 1
        expect(assigns(:cart).id).to eq cart.id
      end
    end
  end
end