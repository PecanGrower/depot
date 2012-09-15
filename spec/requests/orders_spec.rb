require 'spec_helper'

describe "Orders" do
  let!(:product) { create(:product) }
  before do
    visit store_path
    click_button "Add to Cart"
    click_button "Checkout"
  end

  it "displays the 'New Order' page" do
    expect(page).to have_selector '.orders'
  end

  it "displays the cart" do
    expect(page).to have_selector '#side #cart'
  end

  describe "form" do
    
    it "displays the Order form" do
      expect(page).to have_selector '.orders form'
    end

    context "with valid input" do
      before do
        fill_in 'Name', with: 'John Doe'
        fill_in 'Address', with: '123 Main St.'
        fill_in 'Email', with: 'john.doe@example.com'
        select('Credit card', from: 'Pay type')
        click_button 'Place Order'
      end
      
      it "redirects to store" do
        expect(page).to have_selector '.store'
      end

      it "displays 'Thank you' message" do
        expect(page).to have_selector '#notice', text: 'Thank you'
      end

      it "empties the cart" do
        expect(page).to have_selector "#cart [style='display: none']"
      end
    end

    context "with invalid input" do
      before { click_button 'Place Order' }

      it "renders New Order page" do
        expect(page).to have_selector '.orders'
      end

      it "displays error message" do
        expect(page).to have_selector '.error_explanation'
      end

      it "displays the cart" do
        expect(page).to have_selector '#side #cart'
      end
    end
  end


end