class ReviewsController < ApplicationController
  before_action :authenticate_user!, :excpet => [:show]
  def upvote
    @review = Review.find(params[:id])
    # if !(review.has_voted.include?(user.id))
      if @review.update(votes: @review.votes.to_i + 1, has_voted: @review.has_voted.push(@review.user.id))
        respond_to do |format|
          format.html {redirect_to category_product_path(@review.product.category, @review.product)}
          format.js
        end
      end
      # for when user should only vote once
    # else
    #   flash[:notice] = user.user_name + "has already voted"
    #   redirect_to category_product_path(review.product.category, review.product)
    # end
  end
  def downvote
    @review = Review.find(params[:id])
    # if !(review.has_voted.include?(user.id))
      if @review.update(votes: @review.votes.to_i - 1, has_voted: @review.has_voted.push(@review.user.id))
        respond_to do |format|
          format.html {redirect_to category_product_path(@review.product.category, @review.product)}
          format.js
        end
      end
        # for when user should only vote once
    # else
      # flash[:alert] = user.user_name + "has already voted"
      # redirect_to category_product_path(review.product.category, review.product)
    # end
  end
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
    if @review.update(user_id: current_user.id)
      respond_to do |format|
        format.html {redirect_to product_path(@product)}
        format.js
      end
      flash[:notice] = "Review saved successfully"
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
