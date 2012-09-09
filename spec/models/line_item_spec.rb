require 'spec_helper'

describe LineItem do
  let(:cart) { create(:cart) }
  let(:product) { create(:product) }
  let(:line_item) do
    cart.line_items.new(attributes_for(:line_item, product_id: product.id))
  end

  subject { line_item }

  it { should be_valid }

  describe "attributes" do
    
    it { should respond_to :cart_id }
    it { should respond_to :product_id }
    it { should respond_to :quantity }

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

  describe "has associations" do
    
    it { should respond_to :cart }
    it { should respond_to :product }
  end
end
