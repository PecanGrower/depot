require 'spec_helper'

describe "Carts Pages" do

  subject { page }

  describe ":show" do
    let!(:product) { create(:product) }
    before do
      visit store_path
      click_button product.title
    end

    describe "elements" do
      it { should have_selector 'h2', text: 'Your Pragmatic Cart' }
    end

    describe "products" do
      let(:cart) { product.line_items.last.cart } # find current_cart
      let(:other_product) { create(:product) }
      before do
        2.times { cart.add_product(other_product).save }
        visit current_path # reload cart page
      end

      it "are listed with quantities" do
        cart.line_items.each do |item|
          expect(page).to have_selector "#product_#{item.product.id}",
                                        text: item.product.title 
          expect(page).to have_selector "#product_#{item.product.id}",
                                        text: item.quantity.to_s
        end
      end
    end
  end
end