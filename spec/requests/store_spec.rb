require 'spec_helper'

describe "Store" do

  describe "catalog listing" do
    let!(:all_products) { 3.times { create(:product) } }
    before { visit store_path }
  	it "has the correct page elements" do
      # time = Time.now.asctime
  		visit store_path
  		expect(page).to have_selector '#columns #side a', minimum: 4
      expect(page).to have_selector '#time'
      expect(page).to have_selector '#main .entry', count: 3
      Product.all.each do |product|
        expect(page).to have_selector 'h3', text: product.title
      end
      expect(page).to have_selector '.price', text: /\$[,\d]+\.\d\d/
  	end
  end

  describe "add-to-cart button" do
    let!(:product) { create(:product) }
    let!(:other_product) { create(:product) }
    before { visit store_path }

    it "is present" do
      expect(page).to have_button product.title
    end

    xit "adds a new line-item to cart" do
      expect do
        click_button 'Add'
      end.to change(LineItem, :count).by(1)
    end

    xit "redirects to Cart#show" do
     click_button 'Add'
      expect(page).to have_selector 'h2', text: 'Your Pragmatic Cart'
    end

    xit "displays flash[:notice]" do
      click_button 'Add'
      expect(page).to have_selector '#notice'
    end

    xit "displays the product.title" do
      click_button product.title
      expect(page).to have_selector 'li', text: product.title
    end

    xit "displays the product.quantity" do
      click_button 'Add'
      expect(page).to have_selector 'li', text: 'Qty: 1'
    end    
  end
end
