require 'spec_helper'

describe Product do
  
  let!(:product) { Product.new(attributes_for(:product)) }

  subject { product }

  it { should be_valid }

  describe "has attributes" do
  	
  	it { should respond_to :title }
  	it { should respond_to :description }
  	it { should respond_to :image_url }
  	it { should respond_to :price }

  	describe "that validate" do
  		
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

  describe "has associations" do
    
    it { should respond_to :line_items }
    it { should have_many(:orders).through :line_items }

    context "with dependent :line_items" do
      before do        
        product.save
        cart = create(:cart)
        line_item = cart.add_product(product)
        line_item.save
      end

      it "prevents :product.destroy" do
        expect { product.destroy }.not_to change(Product, :count)
      end

      it "has the correct error message" do
        product.destroy
        product.errors[:base].should include 'Line Items present'
      end
    end

    context "without dependent :line_items" do
      
      it "permits :product.destroy" do
        product.save
        expect { product.destroy }.to change(Product, :count).by(-1)
      end
    end
  end
end