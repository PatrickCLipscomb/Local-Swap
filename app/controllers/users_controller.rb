class UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:show_prod]

  def show_prod
    @user = User.find(params[:id])
    @users = User.all
    @categories = Category.all
    respond_to do |format|
      format.html {render categories_path}
      format.js
    end
  end
  def show
    @user = User.find(params[:id])
    @avg_rating = 0
    counter = 0
    if @user.reviews.any?
      @user.reviews.each do |review|
        @avg_rating += review.rating
        counter += 1
      end
      @avg_rating = @avg_rating / counter
      if @avg_rating < 4
        @avg_rating += 1
      end
    end
  end

end
