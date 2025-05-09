class UsersController < ApplicationController
  skip_before_action :require_authentication
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path(Current.user)
    else
      redirect_to "/signup"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      redirect_to profile_path(@user)
    else
      render :edit
    end
  end

  # profile page
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @friendships = @user.all_friendships
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect to "/"
  end

  private
  def user_params
    params.require(:user).permit(:username, :email_address, :password, :bio, :profile_picture)
  end
end
