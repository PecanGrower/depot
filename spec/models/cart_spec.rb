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

  describe "has method" do

    describe "#add_product" do

      it { should respond_to :add_product }
      
      context "when the product is not already in the cart" do
        let(:cart) { create(:cart) }
        let(:product) { create(:product) }
        # let(:line_item) { cart.add_product(product) }

        it "builds a new line_item" do
          line_item = cart.add_product(product)
          expect(line_item).to be_kind_of(LineItem)
        end

        it "adds the correct product to the line item" do
          line_item = cart.add_product(product)
          expect(line_item.product).to eq product
        end

        it "has a quantity of 1" do
          line_item = cart.add_product(product)
          expect(line_item.quantity).to eq 1
        end
      end

      context "when the product is already in the cart" do
        let!(:cart) { create(:cart) }
        let!(:product) { create(:product) }
        let!(:previous_line_item) do
          cart.line_items.create(product_id: product.id)
        end

        it "does not add a new line_item to the cart" do
          line_item = cart.add_product(product)
          expect(line_item).not_to be_a_new(LineItem)
        end

        it "returns an existing line_item" do
          line_item = cart.add_product(product)
          expect(line_item).to be_kind_of(LineItem)
        end

        it "increases the product quantity by 1" do
          line_item = cart.add_product(product)
          expect(line_item.quantity).to eq (previous_line_item.quantity + 1)
        end
      end
    end
  end
end
