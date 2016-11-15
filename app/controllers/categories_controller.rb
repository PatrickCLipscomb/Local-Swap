class CategoriesController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show, :about, :contact]
  skip_before_filter :verify_authenticity_token, :only => [:index]
  def index
    User.all.each
    @categories = Category.all.limit(12)
    @products = Product.all
    @productsLimited = Product.all.paginate(page: params[:page], per_page: 12)
    @total_products_number = 0
    Product.all.each do
      @total_products_number += 1
    end
    @users = User.all
  end
  def show
    @users = User.all
    @category = Category.find(params[:id])
    @first_product = @category.products.first
  end
  def edit
    @category = Category.find(params[:id])
  end
  def new
    @category = Category.new
  end
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category saved successfully"
      respond_to do |format|
        format.html { redirect_to categories_path }
        format.js
      end
    else
      flash[:alert] = "Category failed to save"
      render :new
    end
  end
  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    redirect_to categories_path
  end
  def destroy
    @category = Category.find(params[:id])
    @category.products.each { |product| product.destroy }
    if @category.destroy
      flash[:notice] = "Category and associated products deleted"
      redirect_to categories_path
    else
      flash[:alert] = "Category failed to delete"
    end

  end

  def interests
    @categories = Category.all
  end

  def contact
  end

  def about
  end


  private
  def category_params
    params.require(:category).permit(:name, :image, user_ids:[])
  end
end
