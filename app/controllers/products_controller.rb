class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find_by_id(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
     @product = Product.find_by_id(params[:id])
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to @product
    else
      render :new
    end
  end

  def update
    @product = Product.find_by_id(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find_by_id(params[:id])
    @product.delete
    redirect_to products_path
  end
end
