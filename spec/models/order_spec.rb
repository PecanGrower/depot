require 'spec_helper'

describe Order do

  let(:order) { create(:order) }

  subject { order }

  it { should be_valid }
  
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:address).of_type(:text) }
  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:pay_type).of_type(:string) }

  describe "validations" do
    
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :email }
    it { should ensure_inclusion_of(:pay_type).in_array(Order::PAYMENT_TYPES) }
  end

  describe "associations" do
    
    it { should have_many :line_items }
    # it { should have_many(:products).through(:line_items) }
  end

  describe "method" do
    
    describe "add_line_items_from_cart" do
      before do
        @cart = create(:cart)
        2.times { @cart.add_product(create(:product)) }
        @items = @cart.line_items
      end
      
      it "associates line_items with order" do
        order.add_line_items_from_cart(@cart)
        expect(order.line_items).to eq @items
      end

      it "unassociates line_items from cart" do
        order.add_line_items_from_cart(@cart)
        @cart.reload
        expect(@cart.line_items).to be_empty
      end
    end
  end
end
