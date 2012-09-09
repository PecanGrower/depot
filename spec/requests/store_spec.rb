require 'spec_helper'

describe "Store" do
  let!(:all_products) { 3.times { create(:product) } }
  before { visit store_path }

  describe "catalog listing" do
  	it "has the correct page elements" do
  		visit store_path
  		expect(page).to have_selector '#columns #side a', minimum: 4
      expect(page).to have_selector '#time'
      expect(page).to have_selector '#main .entry', count: 3
  	end

    it "lists all of the products" do
      Product.all.each do |product|
        expect(page).to have_selector 'h3', text: product.title
        expect(page).to have_selector '.price', text: /\$[,\d]+\.\d\d/
        expect(page).to have_selector '.price', text: product.price.to_s
      end
    end
  end

  describe "Add to Cart button" do
    
    it "displays a flash:notice " do
      click_button 'Add'
      expect(page).to have_selector '#notice'
    end
  end
end