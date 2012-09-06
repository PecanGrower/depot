require 'spec_helper'

describe ProductsController do
	let!(:all_products) { 2.times.map { create(:product) } }
	
	describe "GET :index" do
		before { get :index }		

		it "assigns all Products to @products" do
			expect(assigns(:products)).to eq all_products
		end

		it "renders Products#index page" do
			expect(response).to render_template 'products/index'
		end
	end

	describe "GET :show" do
		let(:product) { create(:product) }
		before { get :show, id: product }

		it "assigns correct Product to @product" do
			expect(assigns(:product)).to eq product
		end

		it "renders Products#show page" do
			expect(response).to render_template 'products/show'
		end
	end

	describe "GET :new" do
		before { get :new }
		
		it "assigns a new Product to @product" do
			expect(assigns(:product)).to be_new_record
		end

		it "renders Products#new page" do
			expect(response).to render_template 'products/new'
		end
	end

	describe "POST :create" do
		
		context "with valid attributes" do

			it "assigns correct params to @product" do
				post :create, product: attributes_for(:product, title: "New Product")
				expect(assigns(:product).title).to eq "New Product"
			end
			
			it "saves a new Product in the database" do
				expect do					
					post :create, product: attributes_for(:product)
				end.to change(Product, :count).by(1)
			end

			it "redirects to Products#show page" do
				post :create, product: attributes_for(:product)
				product = Product.last
				expect(response).to redirect_to product
			end
		end

		context "with invalid attributes" do
			
			it "does not save a new Product in the database" do
				expect do
					post :create, product: attributes_for(:invalid_product)
				end.not_to change(Product, :count)
			end

			it "renders Products#new page" do
				post :create, product: attributes_for(:invalid_product)
				expect(response).to render_template 'products/new'
			end
		end
	end

	describe "GET :edit" do
		let(:product) { create(:product) }
		before { get :edit, id: product }

		it "assigns correct Product to @product" do
		 	expect(assigns(:product)).to eq product
		end

		it "renders the Products#edit page" do
			expect(response).to render_template 'products/edit'
		end
	end

	describe "PUT :update" do
		let(:product) { create(:product) }

		context "with valid attributes" do
			before do
				put :update, id: product, 
								product: attributes_for(:product, title: "Updated Product")
			end
	
			it "assigns correct Product to @product" do
				expect(assigns(:product)).to eq product
			end

			it "updates @product in the database" do
				product.reload
				expect(product.title).to eq "Updated Product"				
			end

			it "redirects to Product#show page" do
				expect(response).to redirect_to product
			end
		end

		context "with invalid attributes" do
			before do
				put :update, id: product, 
										 product: attributes_for(:product, title: "Invalid")
			end
			
			it "does not update @product in the database" do
				product.reload
				expect(product.title).not_to eq "Invalid"
			end

			it "renders Product#edit page" do
				expect(response).to render_template 'products/edit'
			end
		end
	end

	describe "DELETE :destroy" do
		let!(:product) { create(:product) }
		before {  }

		it "assigns the correct Product to @product" do
			delete :destroy, id: product
			expect(assigns(:product)).to eq product
		end

		it "deletes record from the database" do
			expect do
				delete :destroy, id: product
			end.to change(Product, :count).by(-1)
		end

		it "redirects to Products#index" do
			delete :destroy, id: product
			expect(response).to redirect_to products_path
		end
	end
end