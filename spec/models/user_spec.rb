require 'spec_helper'

describe User do
  let(:user) { create(:user) }

  subject { user }

  it { should be_valid }

  describe "attribute" do
    it { should have_db_column :name }
    it { should have_db_column :password_digest }
    it { should have_db_index :name }
  end

  describe "MassAssignment" do
    it { should_not allow_mass_assignment_of :password_digest }
    it { should allow_mass_assignment_of :password }
    it { should allow_mass_assignment_of :password_confirmation }
  end

  describe "has_secure_password" do
    it { should respond_to :authenticate }
  end

  describe "validation" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end
end
