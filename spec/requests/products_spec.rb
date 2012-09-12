require 'spec_helper'

describe "Products" do

  subject { page }

  describe ":index" do
    before { visit products_path }

    it { should have_selector 'h1', text: 'Listing products'}
  end
end