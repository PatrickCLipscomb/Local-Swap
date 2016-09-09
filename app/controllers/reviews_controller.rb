class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:id])
    @product = @review.product
  end
  def edit
    @review = Review.find(params[:id])
    @product = @review.product
  end
  def new
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new
  end
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    if @review.save
      flash[:notice] = "Review saved successfully"
      redirect_to product_path(@product)
    else
      flash[:alert] = "Review failed to save"
      render :new
    end
  end
  def update
    @review = Review.find(params[:id])
    @product = @review.product
    @review.update(review_params)
    flash[:notice] = "review updated successfully"
    redirect_to product_path(@product)
  end
  def destroy
    @review = Review.find(params[:id])
    @product = @review.product
    if @review.delete
      flash[:notice] = "Review deleted"
      redirect_to product_path(@product)
    else
      flash[:alert] = "Review failed to delete"
    end
  end
  private
  def review_params
    params.require(:review).permit(:name, :content, :rating, :product_id)
  end
end
