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
    @avg_rating = @user.ratings
  end

end
