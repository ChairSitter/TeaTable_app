require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  describe "GET /index" do
    it "displays the friendships index" do
      get friendships_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("Friendships")
    end
  end
  describe "POST /create" do
    it "creates a friendship" do
      user1 = User.create(email_address: "email@ok.com", password: "password")
      user2 = User.create(email_address: "email@ok.com", password: "password")
      post friendships_path, params: { friendship: { user_id: user1.id, friend_id: user2.id } }
      expect(response).to redirect_to(friendships_path)
      follow_redirect!
      expect(response.body).to include("Friendship was successfully created.")
    end
  end
  describe "DELETE /destroy" do
    it "deletes a friendship" do
      user1 = User.create(email_address: "email@ok.com", password: "password")
      user2 = User.create(email_address: "email@ok.com", password: "password")
      friendship = Friendship.create(user_id: user1.id, friend_id: user2.id)
      delete friendship_path(friendship)
      expect(response).to redirect_to(friendships_path)
      follow_redirect!
      expect(response.body).to include("Friendship was successfully destroyed.")
    end
  end
end
