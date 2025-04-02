class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.where(user_id: Current.user.id)
  end
  def create
    @friendship = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id])
    if @friendship.save
      redirect_to profile_path(params[:friend_id]), notice: "Friend request sent!"
    else
      redirect_to profile_path(params[:friend_id]), alert: "Unable to send friend request."
    end
  end
  def new
    @friendship = Friendship.new
  end
  def destroy
    friendship = Friendship.find(params[:id])
    friendship.destroy
    redirect_to profile_path(current_user)
  end
end
