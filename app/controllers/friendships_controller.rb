class FriendshipsController < ApplicationController
  def index
    @friendships = Friendship.where(user_id: Current.user.id).or(
      Friendship.where(friend_id: Current.user.id)
    )
    @user = User.find(Current.user.id)
  end
  def create
    request = FriendRequest.where(sender_id: params[:sender_id], receiver_id: params[:receiver_id]).first
    @friendship = Friendship.new(user_id: params[:sender_id], friend_id: params[:receiver_id])
    if @friendship.save
      request.destroy
      redirect_to profile_path(params[:receiver_id]), notice: "Friendship created!"
    else
      redirect_to profile_path(params[:receiver_id]), alert: "Unable to create friendship."
    end
  end
  def destroy
    friendship = Friendship.find(params[:id])
    friendship.destroy
    redirect_to profile_path(Current.user)
  end

  private
  def friendship_params
    params.require(:friend_request).permit(:receiver_id, :sender_id)
  end
end
