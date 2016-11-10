class ProductsController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  def index
    @products = Product.all.order('category_id desc').order('name asc')
    @users = User.all
    @categories = Category.all
  end
  def show
    @product = Product.find(params[:id])
    @category = @product.category
    @current_user ||= current_user
  end
  def edit
    @product = Product.find(params[:id])
    @category = @product.category
  end
  def new
    @product = Product.new
    if params[:category_id]
      @category_ID = params[:category_id]
    end
  end

  def crop
    @product = Product.find(params[:id])
    @product.update_attributes(crop_params)
    @product.reprocess_image
    redirect_to user_path(@product.user)
  end

  def create
    @category = Category.find(params[:category_id])
    @product = @category.products.new(product_params)
    @product.update(user_id: current_user.id)
    @product.update(condition: params[:condition].to_i)
    if @product.save
      flash[:notice] = "Product saved successfully"
      if params[:product][:image].blank? && current_user.user_name != 'Admin'
        respond_to do |format|
          format.html {redirect_to user_path(@product.user)}
          format.js
        end
      elsif params[:product][:image].blank?
        redirect_to user_path(@product.user)
      else
        render :crop
      end
    else
      flash[:alert] = "Product failed to save"
      render :new
    end
  end

  def update
    @product = Product.find(params[:id])
    @category = @product.category
    @product.update(condition: params[:condition])
    if @product.update(product_params)
      flash[:notice] = "product updated successfully"
      if params[:product][:image].blank?
        respond_to do |format|
          format.html {redirect_to user_path(@product.user)}
          format.json {render json: @product}
          format.js
        end
      else
        render :crop
      end
    else
      flash[:alert] = "Product failed to update"
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @category = @product.category
    if @product.delete
      flash[:notice] = "Product deleted"
      respond_to do |format|
        format.html {redirect_to category_path(@category)}
        format.json { head :no_content}
      end

    else
      flash[:alert] = "Product failed to delete"
    end
  end
  private
  def product_params
    params.require(:product).permit(:name, :description, :condition, :image, :category_id, :user_id)
  end
  def crop_params
    params.require(:product).permit(:crop_x, :crop_y, :crop_w, :crop_h)
  end
end
