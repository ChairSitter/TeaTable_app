require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /new" do
    it "renders the new session template" do
      get login_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("Log in")
    end
  end
  describe "POST /create" do
    let(:user) { User.create(name: "Test User", email: "email@ok.com", password: "password") }
    it "logs in the user" do
      post login_path, params: { session: { email: user.email, password: user.password } }
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("Logged in successfully.")
    end
  end
  describe "DELETE /destroy" do
    let(:user) { User.create(name: "Test User", email: "email@ok.com", password: "password") }
    it "logs out the user" do
      delete logout_path
      expect(response).to redirect_to(root_path)
      follow_redirect!
      expect(response.body).to include("Logged out successfully.")
    end
  end
end
