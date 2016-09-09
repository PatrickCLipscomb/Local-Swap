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
    @category = @category.update(category_params)
  end
  def destroy
    if @category.delete
      flash[:notice] = "Category deleted"
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
