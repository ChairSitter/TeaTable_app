class FriendRequestsController < ApplicationController
  def index
    @friend_requests = FriendRequest.where(receiver_id: Current.user.id)
    @user = User.find(Current.user.id)
    @users = User.all
  end

  def create
    friend_request = FriendRequest.new(friend_request_params)
    friend_request.sender_id = Current.user.id
    friend_request.receiver_id = params[:friend_request][:receiver_id]

    if friend_request.save
      redirect_to profile_path(Current.user)
    else
      redirect_to profile_path(Current.user), alert: "Friend request not saved."
    end
  end
  def new
    @friend_request = FriendRequest.new
  end
  def destroy
    friend_request = FriendRequest.find(params[:id])
    friend_request.destroy
    redirect_to profile_path(Current.user)
  end

  private
  def friend_request_params
    params.require(:friend_request).permit(:receiver_id, :sender_id)
  end
end
