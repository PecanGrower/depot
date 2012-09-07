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
      expect(page).to have_selector 'h3', text: Product.first.title
      expect(page).to have_selector '.price', text: /\$[,\d]+\.\d\d/
  	end
  end

  describe "add-to-cart button" do
    let!(:all_products) { 3.times { create(:product) } }
    before { visit store_path }

    it "is present" do
      expect(page).to have_button 'Add'
    end

    it "adds a new line-item to cart" do
      expect do
        click_button 'Add'
      end.to change(LineItem, :count).by(1)
    end
  end
end
