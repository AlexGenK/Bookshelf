class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :confirm_perm_param, if: :devise_controller?
  before_action :authenticate_user!

  def confirm_perm_param
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
  end
end
