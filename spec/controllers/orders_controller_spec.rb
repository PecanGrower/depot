require 'spec_helper'

describe OrdersController do

  describe "get :new" do
    before { get :new }

    it { should assign_to(:cart) } #for sidebar cart display
  end

  describe "post :create" do
    before { post :create, order: attributes_for(:order, name: 'John Doe') }
    
    specify { assigns(:order).name.should eq 'John Doe' }
  end
end
