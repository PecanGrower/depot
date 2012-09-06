require 'spec_helper'

describe "Store" do
  describe "GET :index" do
    let!(:all_products) { 3.times { create(:product) } }
    before { visit store_path }
  	it "has the correct page elements" do
      # time = Time.now.asctime
  		visit store_path
  		expect(page).to have_selector '#columns #side a', minimum: 4
      expect(page).to have_selector '#time', text: Time.now.asctime
      expect(page).to have_selector '#main .entry', count: 3
      expect(page).to have_selector 'h3', text: Product.first.title
      expect(page).to have_selector '.price', text: /\$[,\d]+\.\d\d/
  	end
  end
end
