class FriendRequestsController < ApplicationController
  def index
    @friend_requests = FriendRequest.where(friend_id: Current.user.id)
  end

  def create
    friend_request = FriendRequest.new(friend_request_params)
    friend_request.sender_id = Current.user.id

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
    params.require(:friend_request).permit(:friend_id)
  end
end
