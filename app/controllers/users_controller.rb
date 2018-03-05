class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]
  before_action :set_user, only: [:update, :destroy]
  load_and_authorize_resource

  def index
    @users = User.order(:username)
  end

  def update
    if (@user.superadmin_role?) && (User.where(superadmin_role: true).count <= 1) && (user_params[:superadmin_role] == "0")
      flash[:alert] = 'Unable delete last superadmin role'
    else
      @user.update(user_params) ? flash[:notice] = 'Roles was successfully updated' : flash[:alert] = 'Unable update roles of the user'
    end
    redirect_to users_path
  end

  def destroy
    if (@user.superadmin_role?) && (User.where(superadmin_role: true).count <= 1)
      flash[:alert] = 'Unable delete last superadmin'
    else
      @user.destroy ? flash[:notice] = 'User was deleted' : flash[:alert] = 'Unable deleted that user'
    end
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
