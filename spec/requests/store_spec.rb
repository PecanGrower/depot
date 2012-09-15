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

      describe "checkout button" do

        it "is displayed" do
          expect(page).to have_selector "form.button_to 
                                         [action=\"#{new_order_path}\"]
                                         [method=get]"
        end

        context "when the cart is empty" do
          
          it "redirects to Store page" do
            click_button "Checkout"
            expect(page).to have_selector '.store'
          end

          it "displays a notice" do
            click_button "Checkout"
            expect(page).to have_selector '.store #notice'
          end
        end

        context "when cart has LineItem" do
          before { click_button "Add to Cart" }

          it "redirects to New Order page" do
            click_button "Checkout"
            expect(page).to have_selector '.orders'
          end
        end
      end
    end
  end

  describe "catalog listing" do

  	describe "elements" do
      it { should have_selector '#main .entry', count: 2 }
      
      context "needed for store.js.coffee" do
        it { should have_selector '.store .entry img', count: 2 }
        it { should have_selector '.entry input[type=submit]' }
      end
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