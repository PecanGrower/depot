require 'spec_helper'

describe LineItem do
  let(:cart) { create(:cart) }
  let(:product) { create(:product) }
  let(:line_item) do
    cart.add_product(product)
  end

  subject { line_item }

  it { should be_valid }

  describe "attributes" do
    
    it { should respond_to :cart_id }
    it { should respond_to :product_id }
    it { should respond_to :quantity }
    it { should respond_to :price }

    describe "MassAssignment protection" do
      
      it "does not allow access to cart_id" do
        expect do
          LineItem.new(cart_id: 1)
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end

      it "does not allow access to :quantity" do
        expect do
          LineItem.new(quantity: 1)
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end

      it "does not allow access to :price" do
        expect do
          LineItem.new(price: 1)
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end
    end

    describe "validate" do
      
      it "is invalid without :cart_id" do
        line_item.cart_id = nil
        expect(line_item).not_to be_valid
      end

      it "is invalid without :product_id" do
        line_item.product_id = nil
        expect(line_item).not_to be_valid
      end

      it "is invalid without a numerical :price" do
        line_item.price = nil
        expect(line_item).not_to be_valid
      end
    end

    describe "default value" do

      describe "for :quantity" do
        
        it "is 1 after .build" do
          expect(line_item.quantity).to eq 1
        end
        
        it "is 1 for quantity when nil" do
          line_item.quantity = nil
          line_item.save
          line_item.reload
          expect(line_item.quantity).to eq 1
        end

        it "is not changed when non-nil" do
          line_item.quantity = 2
          line_item.save
          line_item.reload
          expect(line_item.quantity).to eq 2
        end
      end
    end
  end

  describe "associations" do
    
    it { should respond_to :cart }
    it { should respond_to :product }
  end

  describe "methods" do
    
    describe "#total_price" do
      before do
        line_item.quantity = 2
        line_item.save
        product.price += 1 # Ensure product.price !eq line_item.price
        product.save
      end

      it "calculates quantity * line_item.price" do
        expected_total = line_item.quantity * line_item.price
        expect(line_item.total_price.to_s).to eq expected_total.to_s
      end
    end
  end
end
