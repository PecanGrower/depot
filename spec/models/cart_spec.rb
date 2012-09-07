require 'spec_helper'

describe Cart do
  
  let(:cart) { Cart.new(attributes_for(:cart)) }

  subject { cart }

  it { should be_valid }

  describe "has associations" do
    
    it { should respond_to :line_items }

    it "that destroy dependent :line_items" do
      cart.save
      cart.line_items.create(product_id: create(:product).id)
      cart.destroy
      expect(LineItem.find_by_cart_id(cart.id)).to be_nil
    end
  end
end
