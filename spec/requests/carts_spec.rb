require 'spec_helper'

describe "Carts Pages" do

  describe ":show" do
    # let(:cart) { create(:cart) }
    let!(:first_product) { create(:product) }
    let!(:second_product) { create(:product) }
    before do
      visit store_path
      click_button first_product.title
    end
    it "has the correct elements" do
      visit cart_path(1)
      line_item = first_product.line_items.first
      expect(page).to have_selector 'h2', text: 'Your Pragmatic Cart'
      expect(page).to have_selector "#product_#{first_product.id}",
                                    text: first_product.title
      expect(page).to have_selector "#product_#{first_product.id}", 
                                    text: line_item.quantity.to_s
    end
  end
end