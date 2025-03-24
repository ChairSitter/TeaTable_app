class UsersController < ApplicationController
  skip_before_action :require_authentication
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/"
    else
      redirect_to "/signup"
    end
  end

  # profile page
  def show
    @user = User.find(params[:id])
    # @posts = @user.posts
  end

  private
  def user_params
    params.require(:user).permit(:username, :email_address, :password)
  end
end
