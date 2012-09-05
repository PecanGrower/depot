require 'spec_helper'

describe Product do
  
  let(:product) { build(:product) }

  subject { product }

  it { should be_valid }

  describe "attributes" do
  	
  	it { should respond_to :title }
  	it { should respond_to :description }
  	it { should respond_to :image_url }
  	it { should respond_to :price }

  	describe "validate" do
  		
  		describe ":title" do

  			it "is invalid when less than 10 characters" do
  				product.title = "a" * 9
  				expect(product).not_to be_valid
  			end

        it "is invalid when duplicated" do
          product.title = "Duplicate Title"
          product.save
          expect(build :product, title: "Duplicate Title").not_to be_valid
        end
  		end

  		describe ":description" do

        it "is invlaid when blank" do
          product.description = " "
          expect(product).not_to be_valid
        end
  		end

  		describe ":image_url" do

        context "with proper format" do
          %w{ fred.jpg http://a.b.c/Xyz.GIF ./path/foo.Png }.each do |attr|
            it "is valid" do
              product.image_url = attr
              expect(product).to be_valid
            end
          end
        end

        context "with improper format" do
          %w{ fred,jpg http://a.b.c/Xyz.GIF? ./path/foo.doc }.each do |attr|
            it "is invalid" do
              product.image_url = attr
              expect(product).not_to be_valid
            end
          end
        end
  		end

  		describe ":price" do

        it "is invalid if less than 0.01" do
          product.price = 0
          expect(product).not_to be_valid
        end
  		end
  	end
  end
end
