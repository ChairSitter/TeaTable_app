class PostsController < ApplicationController
  def index
    @posts = Post.where(user_id: Current.user.friends.pluck(:friend_id))
    @posts = Post.where(user_id: Current.user.friends.pluck(:friend_id) << Current.user.id)
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    if post.save
      redirect_to post
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])

    if post.update(post_params)
      redirect_to post
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to profile_path(Current.user)
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :user_id)
  end
end
