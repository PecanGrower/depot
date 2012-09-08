require 'spec_helper'

describe LineItemsController do

  describe "POST :create" do
    let(:product) { create(:product) }
    let(:cart) { create(:cart) }

    it "assigns the correct product to @product" do
      post :create, product_id: product.id
      expect(assigns(:product)).to eq product
    end

    describe "#current_cart method" do
      
      context "when there is no current_cart" do
        before { session[:cart_id] = nil }

        it "creates a new cart" do
          expect do
            post :create, product_id: product.id
          end.to change(Cart, :count).by(1)
        end

        it "assigns current_cart.id to session[:cart_id]" do
          post :create, product_id: product.id
          expect(session[:cart_id]).to eq Cart.last.id
        end

        it "assigns the current_cart to @cart" do
          post :create, product_id: product.id
          expect(assigns(:cart).id).to eq session[:cart_id]
        end
      end

      context "when there is a current_cart" do
        before { session[:cart_id] = cart.id }

        it "assigns the current_cart to @cart" do
          post :create, product_id: product.id
          expect(assigns(:cart).id).to eq cart.id
        end
      end
    end

    
    xit "increments the quantity of existing line_items" do
      2.times { post :create, product_id: product.id }
      item = assigns(:line_item)
      expect(item.quantity).to eq 2
    end
  end

end
