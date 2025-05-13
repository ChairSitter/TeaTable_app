require 'rails_helper'

RSpec.describe "FriendRequests", type: :request do
  describe "GET /index" do
    it "renders the index template" do
      get friend_requests_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("Friend Requests")
    end
  end
  describe "GET /new" do
    it "renders the new template" do
      get new_friend_request_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("New Friend Request")
    end
  end
  describe "POST /create" do
    let(:user) { User.create(name: "Test User", email: "email@ok.com", password: "password") }
    let(:friend) { User.create(name: "Friend User", email: "email@ok.com", password: "password") }
    it "creates a friend request" do
      post friend_requests_path, params: { friend_request: { sender_id: user.id, receiver_id: friend.id } }
      expect(response).to redirect_to(friend_requests_path)
      follow_redirect!
      expect(response.body).to include("Friend request was successfully created.")
    end
  end
  describe "DELETE /destroy" do
    let(:user) { User.create(name: "Test User", email: "email@ok.com", password: "password") }
    let(:friend) { User.create(name: "Friend User", email: "email@ok.com", password: "password") }
    let(:friend_request) { FriendRequest.create(sender_id: user.id, receiver_id: friend.id) }
    it "deletes a friend request" do
      delete friend_request_path(friend_request)
      expect(response).to redirect_to(friend_requests_path)
      follow_redirect!
      expect(response.body).to include("Friend request was successfully destroyed.")
    end
  end
end
