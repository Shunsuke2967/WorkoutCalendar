class SessionsController < ApplicationController

  skip_before_action :login_required

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'ログインしました。'
    else
      redirect_to sessions_new_path, notice: 'ログインに失敗しました'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "ログアウトしました。"
  end

  private

  def session_params
    params.require(:session).permit(:email,:password)
  end
end
