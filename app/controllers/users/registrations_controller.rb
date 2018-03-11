class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, :redirect_unless_signed_in, only: [:new, :create]
  skip_before_action :require_no_authentication

  private

  def redirect_unless_signed_in
    unless user_signed_in?
      flash[:alert] = "Only registered users can do that"
      redirect_to root_path
    end
  end

  def sign_up(resource_name, resource)
    true
  end
end
