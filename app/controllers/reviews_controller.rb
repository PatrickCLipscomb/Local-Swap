class ReviewsController < ApplicationController
  before_action :authenticate_user!, :excpet => [:show]
  def upvote
    review = Review.find(params[:id])
    user = review.user
    current_vote = review.votes.to_i
    if !(review.has_voted.include?(user.id))
      review.update(votes: current_vote + 1, has_voted: review.has_voted.push(user.id))
      review.save
      redirect_to category_product_path(review.product.category, review.product)
    else
      flash[:notice] = user.user_name + "has already voted"
      redirect_to category_product_path(review.product.category, review.product)
    end
  end
  def downvote
    review = Review.find(params[:id])
    user = review.user
    current_vote = review.votes.to_i
    if !(review.has_voted.include?(user.id))
      review.update(votes: current_vote - 1, has_voted: review.has_voted.push(user.id))
      review.save
      redirect_to category_product_path(review.product.category, review.product)
    else
      flash[:alert] = user.user_name + "has already voted"
      redirect_to category_product_path(review.product.category, review.product)
    end
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
    @review.update(user_id: current_user.id)
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
