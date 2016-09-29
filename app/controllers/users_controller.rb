class UsersController < ApplicationController
  before_action :authenticate_user!

  def show_prod
    @user = User.find(params[:id])
    @products_array = []
    @user.products.each do |prod|
      @products_array.push(prod.name)
    end
    @users = User.all
    @categories = Category.all
    respond_to do |format|
      format.html {render categories_path}
      format.js
    end
  end

end
