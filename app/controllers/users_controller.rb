class UsersController < ApplicationController

  skip_before_action :login_required

  def index
  end

  def new
    @user =User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'ログインしました。'
    else
      render :new
    end
  end

  def update
    after_user = current_user

    if current_user.update(current_user_params)
      current_user.update_time(after_user)
      redirect_to user_path(current_user), notice: "MAXを更新しました。"
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :email,:benchpress,:squat,:deadlift, :password, :password_confirmation)
  end

  def current_user_params
    params.require(:user).permit(:squat,:deadlift,:benchpress)
  end

end