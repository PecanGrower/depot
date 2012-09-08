require 'spec_helper'

describe LineItemsController do

  describe "POST :create" do
    let(:product) { create(:product) }
    let(:cart) { create(:cart) }

    it "assigns the correct product to @product" do
      post :create, product_id: product.id
      expect(assigns(:product)).to eq product
    end
    
    xit "increments the quantity of existing line_items" do
      2.times { post :create, product_id: product.id }
      item = assigns(:line_item)
      expect(item.quantity).to eq 2
    end
  end

end
