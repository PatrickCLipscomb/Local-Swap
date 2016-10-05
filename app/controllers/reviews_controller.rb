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
    @user = User.find(params[:user_id])
    @review = @user.reviews.new
  end
  def create
    @user = User.find(params[:user_id])
    @review = @user.reviews.new(review_params)
    binding.pry
    if @review.update(author_id: current_user.id)
      redirect_to user_path(@user)
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
    params.require(:review).permit(:content, :rating)
  end
end
