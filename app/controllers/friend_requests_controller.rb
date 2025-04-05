class FriendRequestsController < ApplicationController
  def index
    @friend_requests = FriendRequest.where(friend_id: current_user.id)
  end

  def create
    friend_request = FriendRequest.new(friend_request_params)
    friend_request.user_id = current_user.id

    if friend_request.save
      redirect_to profile_path(current_user)
    else
      redirect_to profile_path(current_user), alert: "Friend request not saved."
    end
  end
  def new
    @friend_request = FriendRequest.new
  end
  def destroy
    friend_request = FriendRequest.find(params[:id])
    friend_request.destroy
    redirect_to profile_path(current_user)
  end

  private
  def friend_request_params
    params.require(:friend_request).permit(:friend_id)
  end
end
