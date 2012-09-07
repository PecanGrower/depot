require 'spec_helper'

describe LineItem do
  let(:cart) { create(:cart) }
  let(:product) { create(:product) }
  let(:line_item) do
    cart.line_items.new(attributes_for(:line_item, product_id: product.id))
  end

  subject { line_item }

  it { should be_valid }

  describe "has attributes" do
    
    it { should respond_to :cart_id }
    it { should respond_to :product_id }

    describe "protected from MassAssignment" do
      
      it "does not allow access to cart_id" do
        expect do
          LineItem.new(cart_id: 1)
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end
    end

    describe "which validate" do
      
      it "is invalid without :cart_id" do
        line_item.cart_id = nil
        expect(line_item).not_to be_valid
      end

      it "is invalid without :product_id" do
        line_item.product_id = nil
        expect(line_item).not_to be_valid
      end
    end
  end

  describe "has associations" do
    
    it { should respond_to :cart }
    it { should respond_to :product }
  end
end
