require 'spec_helper'

describe LineItemsController do

  describe "POST :create" do
    let(:product) { create(:product) }
    let(:cart) { create(:cart) }

    it "assigns the correct Cart when user has a cart" do
      session[:cart_id] = cart.id
      post :create, product_id: product.id
      expect(assigns(:cart).id).to eq cart.id
    end

    it "creates a new Cart when user does not have a cart" do
      expect do
        post :create, product_id: product.id
      end.to change(Cart, :count).by(1)
    end

    it "assigns the correct product to @product" do
      post :create, product_id: product.id
      expect(assigns(:product)).to eq product
    end

    context "when product is previously in cart" do
      before do
        session[:cart_id] = cart.id
        cart.line_items.create(product_id: product.id)
      end

      it "assigns an exisiting product LineItem to @line_item" do
        post :create, product_id: product.id
        expect(assigns(:line_item).new_record?).to be_false
      end

      it "increments the quantity of existing product line_item" do
        post :create, product_id: product.id
        expect(assigns(:line_item).quantity).to eq 2
      end
    end

    it "saves the line_item" do
      post :create, product_id: product.id
      expect(assigns(:line_item)).not_to be_changed
    end

    it "redirects to cart#show after saving line_item" do
      session[:cart_id] = cart.id
      post :create, product_id: product.id
      expect(response).to redirect_to(cart_path(cart.id))
    end

    # it "has a :notice flash" do
    #   post :create, product_id: product.id
    #   expect(response).to have_selector 'p', text: 'Line item was success'
    # end
  end
end