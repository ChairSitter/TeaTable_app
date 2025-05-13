require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it "displays the users index" do
      get users_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("Users")
    end
  end
  describe "GET /show" do
    let(:user) { User.create(name: "Test User", email: "email@ok.com", password: "password") }
    it "shows a user" do
      get user_path(user)
      expect(response).to have_http_status(200)
      expect(response.body).to include("User Profile")
    end
    it "displays the user's name" do
      get user_path(user)
      expect(response.body).to include(user.name)
    end
  end
  describe "POST /create" do
    it "creates a user" do
      post users_path, params: { user: { name: "Test User", email: "email@ok.com", password: "password" } }
      expect(response).to redirect_to(user_path(User.last))
      follow_redirect!
      expect(response.body).to include("User was successfully created.")
    end
  end
  describe "DELETE /destroy" do
    let(:user) { User.create(name: "Test User", email: "email@ok.com", password: "password") }
    it "deletes a user" do
      delete user_path(user)
      expect(response).to redirect_to(users_path)
      follow_redirect!
      expect(response.body).to include("User was successfully destroyed.")
    end
  end
end
