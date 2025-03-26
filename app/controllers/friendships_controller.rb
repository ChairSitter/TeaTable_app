class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.where(user_id: Current.user.id)
  end
  def destroy
    friendship = Friendship.find(params[:id])
    friendship.destroy
    redirect_to profile_path(current_user)
  end
end
