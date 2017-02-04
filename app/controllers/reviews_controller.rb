class ReviewsController < ApplicationController
  before_action :authenticate_user!, :excpet => [:show]
  def upvote
    @review = Review.find(params[:id])
    if !(@review.has_voted.include?(current_user.id))
      if @review.update(votes: @review.votes.to_i + 1, has_voted: @review.has_voted.push(current_user.id))
        respond_to do |format|
          format.html {redirect_to user_path(@review.user)}
          format.js
        end
      end
    else
      flash[:notice] = current_user.user_name + " has already voted"
    end
  end
  def downvote
    @review = Review.find(params[:id])
    if !(@review.has_voted.include?(current_user.id))
      if @review.update(votes: @review.votes.to_i - 1, has_voted: @review.has_voted.push(current_user.id))
        respond_to do |format|
          format.html {redirect_to user_path(@review.user)}
          format.js
        end
      end
    else
      flash[:alert] = current_user.user_name + " has already voted"
    end
  end
  def show
    @review = Review.find(params[:id])
    @author = User.find(@review.author_id)
  end
  def edit
    @review = Review.find(params[:id])
    @user = @review.user
  end
  def new
    @user = User.find(params[:user_id])
    @review = @user.reviews.new
  end
  def create
    @user = User.find(params[:user_id])
    @review = @user.reviews.new(review_params)
    @review.update(rating: params[:rating].to_i)
    if @review.update(author_id: current_user.id)
      flash[:notice] = "Review saved successfully"
      respond_to do |format|
        format.html {redirect_to user_path(@user)}
        format.js
      end
    else
      flash[:alert] = "Review failed to save"
      render :new
    end
  end
  def update
    @review = Review.find(params[:id])
    @review.update(rating: params[:rating])
    @review.update(review_params)
    flash[:notice] = "review updated successfully"
    redirect_to user_path(@review.user)
  end
  def destroy
    @review = Review.find(params[:id])
    if @review.delete
      flash[:notice] = "Review deleted"
      redirect_to user_path(@review.user)
    else
      flash[:alert] = "Review failed to delete"
    end
  end
  private
  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
