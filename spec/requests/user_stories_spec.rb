require 'spec_helper'

describe "UserStories" do
  describe "first story" do
    # A user goes to the index page. They select a product, adding it to their
    # cart, and check out, filling in their details on the checkout form. When
    # they submit, an order is created containing their information, along with
    # a single line item corresponding to the product they added to their cart.
 
    before do
      2.times {create(:product) }
    end
    it "purchasing a product" do
      visit store_path
      click_button "Add to Cart"
      click_button "Checkout"
      fill_in "Name", with: "John Doe"
      fill_in "Address", with: "123 Main St"
      fill_in "Email", with: "john.doe@example.com"
      select 'Credit card', from: 'Pay type'
      expect do
        click_button 'Place Order'
      end.to change(Order, :count).by(1)
      order = Order.last
      order.name.should eq "John Doe"
      order.address.should eq "123 Main St"
      order.email.should eq "john.doe@example.com"
      order.line_items.count.should eq 1
      order.line_items.last.product_id.should eq Product.first.id
      mail = ActionMailer::Base.deliveries.last
      mail.to.should eq ["john.doe@example.com"]
      mail.body.should match Product.first.title
    end
  end
end
