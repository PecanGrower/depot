require 'spec_helper'

describe Cart do
  
  let(:cart) { Cart.new(attributes_for(:cart)) }

  subject { cart }

  it { should be_valid }

  describe "has association" do
    
    it { should respond_to :line_items }

    it "that destroy dependent :line_items" do
      cart.save
      cart.add_product(create(:product)).save
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

        it "sets line_item.price as product.price" do
          line_item = cart.add_product(product)
          expect(line_item.price).to eq product.price
        end
      end

      context "when the product is already in the cart" do
        let!(:product) { create(:product) }
        before do
          cart.save
          @previous_item = cart.add_product(product)
          @previous_item.save
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
          expect(line_item.quantity).to eq (@previous_item.quantity + 1)
        end
      end
    end

    describe "#total_price" do
      
      it "is the sum of line_item.total_price" do
        cart.save
        product = create(:product)
        other_product = create(:product)
        item = cart.add_product(product)
        other_item = cart.add_product(other_product)
        item.save
        other_item.save
        expected_price = item.total_price + other_item.total_price
        expect(cart.total_price).to eq expected_price
      end
    end
  end
end
