class SessionsController < ApplicationController
  def new
  end

  def create

    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to questions_path
    else
      flash[:alert] = "メールアドレスまたはパスワードが違います"
      redirect_to login_path
    end
  end

  def guest
    user = User.guest
    session[:user_id] = user.id
    redirect_to questions_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
