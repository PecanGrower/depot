require 'spec_helper'

describe "Carts Pages" do

  describe ":show" do
    let!(:product) { create(:product) }
    before do
      visit store_path
      click_button product.title # redirect_to cart_path(@cart)
      @line_item = product.line_items.first
    end

    it "has the correct elements" do
      expect(page).to have_selector 'h2', text: 'Your Pragmatic Cart'
      expect(page).to have_selector "#product_#{product.id}",
                                    text: product.title
      expect(page).to have_selector "#product_#{product.id}", 
                                    text: @line_item.quantity.to_s
    end
  end
end