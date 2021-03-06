require 'spec_helper'

describe LineItemsController do
  let(:product) { create(:product) }
  let(:cart) { create(:cart) }


  describe "POST :create" do
    before do
      session[:cart_id] = cart.id
      post :create, product_id: product.id
    end

    it "creates new line_item using html" do
      expect { post :create, product_id: create(:product) }.to change(LineItem, :count).by(1)
    end

    it "assigns current_cart to @cart" do
      expect(assigns(:cart)).to eq cart
    end

    context "when using AJAX" do
      render_views
      
      it "creates new LineItem" do
        expect do
          xhr :post, :create, product_id: create(:product)
        end.to change(LineItem, :count).by(1)
      end

      it "responds with success" do
        xhr :post, :create, product_id: create(:product)
        expect(response).to be_success
      end

      it "returns LineItem with Product.title css id: current_item" do
        xhr :post, :create, product_id: product
        assert_select_jquery :html, '#cart' do
          assert_select 'tr#current_item td', product.title
        end
      end
    end

    context "when user has a cart" do

      it "saves the line_item" do
        expect(assigns(:line_item)).not_to be_changed
      end

      it "redirects to store after saving line_item" do
        expect(response).to redirect_to(store_url)
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

  describe "DELETE :destroy" do
    let(:line_item) { cart.line_items.first }
    before do
      session[:cart_id] = cart.id
      item = cart.add_product(product)
      item.save
    end

    it "assigns the correct line_item to @line_item" do
      delete :destroy, id: line_item
      expect(assigns(:line_item)).to eq line_item
    end

    it "deletes line_item" do
      expect do
        delete :destroy, id: line_item
      end.to change(LineItem, :count).by(-1)
    end
  end
end