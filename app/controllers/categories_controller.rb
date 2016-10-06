class CategoriesController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  skip_before_filter :verify_authenticity_token, :only => [:index]
  def index
    @categories = Category.all
    @products = Product.all.paginate(page: params[:page], per_page: 10)
    @users = User.all
    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.infowindow user.user_name
      marker.json({ title: "Name :#{user.user_name} Email: #{user.email}"  })
    end
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
    if @category.destroy
      @category.products.each { |product| product.destroy }
      flash[:notice] = "Category and associated products deleted"
      redirect_to categories_path
    else
      flash[:alert] = "Category failed to delete"
    end

  end
  def contact

  end
  def about

  end
  private
  def category_params
    params.require(:category).permit(:name, :image)
  end
end
