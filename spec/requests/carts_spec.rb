require 'spec_helper'

describe "Carts Pages" do

  subject { page }

  describe ":show" do
    let!(:product) { create(:product) }
    let(:cart) { product.line_items.last.cart } # find current_cart
    before do # create cart and add 1 line_item
      visit store_path
      click_button product.title 
    end

    describe "elements" do
      it { should have_selector '.cart_title', text: 'Your Cart' }
      it { should have_button 'Empty cart' }
    end

    describe "line items" do
      let(:other_product) { create(:product) }
      before do
        2.times { cart.add_product(other_product).save }
        visit current_path # reload cart page
      end

      it "lists products with quantity and 'remove' button" do
        cart.line_items.each do |item|
          expect(page).to have_selector "#product_#{item.product.id}",
                                        text: item.product.title 
          expect(page).to have_selector "#product_#{item.product.id}",
                                        text: item.quantity.to_s
          expect(page).to have_button "Remove item"
        end
      end
    end

    describe "remove_item button" do
      let(:item) { cart.line_items.first }

      it { should have_selector "form.button_to
                                 [action*=\"#{line_item_path(item)}\"]
                                 input[value=delete]" }

      it "redirects to cart" do
        click_button "Remove item"
        expect(page).to have_selector '.cart_title', text: 'Your Cart'
      end
    end

    describe "empty_cart button" do
      it { should have_selector "form.button_to
                                 [action*=\"#{cart_path(cart)}\"] 
                                 input[value=delete]" }
      it "deletes cart" do
        expect{ click_button 'Empty cart' }.to change(Cart, :count).by(-1)
      end

      it "displays :notice message" do
        click_button 'Empty cart'
        expect(page).to have_selector '#notice', text: 'Your cart'
      end
    end
  end
end