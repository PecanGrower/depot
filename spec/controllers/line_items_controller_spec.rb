require 'spec_helper'

describe LineItemsController do

  describe "POST :create" do
    let(:product) { create(:product) }
    let(:cart) { create(:cart) }
    before do
      session[:cart_id] = cart.id
      post :create, product_id: product.id
    end

    context "when user has a cart" do

      it "saves the line_item" do
        expect(assigns(:line_item)).not_to be_changed
      end

      it "redirects to cart#show after saving line_item" do
        expect(response).to redirect_to(cart_path(cart.id))
      end

      context "when product is previously in cart" do
        before do
          post :create, product_id: product.id
        end

        it "assigns an exisiting product LineItem to @line_item" do
          expect(assigns(:line_item).new_record?).to be_false
        end

        it "increments the quantity of existing product line_item" do
          expect(assigns(:line_item).quantity).to eq 2
        end
      end
    end

    context "when user does not have a cart" do
      before { session[:cart_id] = nil }

      it "creates a new Cart" do
        expect do
          post :create, product_id: product.id
        end.to change(Cart, :count).by(1)
      end
    end
  end
end