class ApplicationController < ActionController::Base
  include Authorization
  include Pagy::Backend

  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username name bio])
  end

  def after_sign_in_path_for(_source)
    feed_posts_path
  end
end
