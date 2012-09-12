require 'spec_helper'

describe "Store" do
  before do
    2.times { create(:product) }
    visit store_path
  end

  subject { page }

  describe "sidebar" do

    describe "elements" do
      it { should have_selector '#time' }
    end  
    
    describe "links" do
      it { should have_link 'Home', href: store_path }
    end

    describe "cart" do
      
      context "when empty" do
        it { should have_selector '#side #cart [style="display: none"]' }
      end

      context "with items" do
        before { click_button "Add to Cart" }

        it { should have_selector '#side #cart', text: 'Your Cart' }
        it { should_not have_selector '#side #cart [style="display: none"]' }
      end
    end
  end

  describe "catalog listing" do

  	describe "elements" do

      it { should have_selector '#main .entry', count: 2 }
  	end

    it "lists all of the products" do
      Product.all.each do |product|
        expect(page).to have_selector 'h3', text: product.title
        expect(page).to have_selector '.price', text: /\$[,\d]+\.\d\d/
        expect(page).to have_selector '.price', text: product.price.to_s
        expect(page).to have_button product.title
      end
    end
  end
end