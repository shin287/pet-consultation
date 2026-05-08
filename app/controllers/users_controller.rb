class UsersController < ApplicationController
  before_action :require_admin, only: [:new_expert, :create_expert]

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

  def require_admin
    unless current_user&.role == "admin"
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
