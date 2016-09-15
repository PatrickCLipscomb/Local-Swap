class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end
  def show
    @category = Category.find(params[:id])
  end
  def edit
    @category = Category.find(params[:id])
  end
  def new
    @category = Category.new
  end
  def create
    @category = Category.create(category_params)
    if @category
      flash[:notice] = "Category saved successfully"
      redirect_to categories_path
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
    if @category.destroy
      @category.products.each { |product| product.destroy }
      flash[:notice] = "Category and associated products deleted"
      respond_to do |format|
        format.js
      end
      redirect_to categories_path
    else
      flash[:alert] = "Category failed to delete"
    end

  end
  private
  def category_params
    params.require(:category).permit(:name, :image)
  end
end
