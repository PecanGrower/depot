require 'spec_helper'

describe "Store" do
  describe "GET /Store" do
  	it "renders Store#index" do
  		visit store_path
  		expect(page).to have_content 'Catalog'
  	end
  end
end
