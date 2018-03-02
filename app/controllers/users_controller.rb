class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]
  before_action :set_user, only: [:update, :destroy]
  load_and_authorize_resource

  def index
    @users = User.order(:username)
  end

  def update
    @user.update(user_params) ? flash[:notice] = 'Roles was successfully updated' : flash[:alert] = 'Unable update roles of the user'
    redirect_to users_path
  end

  def destroy
    @user.destroy ? flash[:notice] = 'User was destroyed' : flash[:alert] = 'Unable destroy that user'
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:superadmin_role, :admin_books_role, :admin_categories_role)
  end
end
