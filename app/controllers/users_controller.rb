class UsersController < ApplicationController
  before_action :require_admin, only: [:new_expert, :create_expert]
  before_action :require_login, only: [:show]
  before_action :correct_user_or_admin, only: [:show]

  def new_expert
    @user = User.new
  end

  def create_expert
    @user = User.new(user_params)
    @user.role = "expert"

    if @user.save
      redirect_to root_path
    else
      render :new_expert, status: :unprocessable_entity
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def require_login
    unless current_user
      redirect_to login_path
    end
  end

  def correct_user_or_admin
    @user = User.find(params[:id])
    unless @user == current_user || current_user&.role == "admin"
      redirect_to root_path
    end
  end

  def require_admin
    unless current_user&.role == "admin"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
