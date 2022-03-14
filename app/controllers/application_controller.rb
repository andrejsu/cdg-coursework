class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def authenticate_user!
    if (user_signed_in?)
      super
    else
      redirect_to new_user_session_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :bio])
  end

  def after_sign_in_path_for(source)
    posts_path
  end
end
