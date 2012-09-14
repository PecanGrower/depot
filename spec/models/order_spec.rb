require 'spec_helper'

describe Order do

  let(:order) { create(:order) }

  subject { order }

  it { should be_valid }
  
  it { should have_db_column(:name).of_type(:string) }
  it { should have_db_column(:address).of_type(:text) }
  it { should have_db_column(:email).of_type(:string) }
  it { should have_db_column(:pay_type).of_type(:string) }

  describe "associations" do
    
    it { should have_many :line_items }
  end
end
