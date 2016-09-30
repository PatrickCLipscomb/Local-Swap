class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound do
    flash[:alert] = 'Resource Not Found'
    redirect_back_or root_path
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end

  # def gravatar_for(user, size = 30, title = user.name)
  #   image_tag gravatar_image_url(user.email, size: size), title: title, class: 'img-rounded'
  # end

   protected

       def configure_permitted_parameters
           devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :address, :email, :avatar, :password])
           devise_parameter_sanitizer.permit(:account_update, keys: [:user_name, :address, :email, :avatar, :password, :current_password])
       end
end
