require 'rails_helper'

RSpec.describe "Passwords", type: :request do
  describe "GET /new" do
    it "returns a successful response" do
      get new_password_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("Reset Password")
    end
  end

  describe "POST /create" do
    it "sends a password reset email" do
      post passwords_path, params: { email: "email@ok.com" }
      expect(response).to redirect_to(new_session_path)
      follow_redirect!
      expect(response.body).to include("Password reset instructions sent (if user with that email address exists).")
    end
  end
  describe "GET /edit" do
    it "returns a successful response" do
      user = User.create(email_address: "email.@ok.com", password: "password")
      user.generate_password_reset_token!
      get edit_password_path(user.password_reset_token)
      expect(response).to have_http_status(200)
      expect(response.body).to include("Reset Password")
    end
  end
  describe "PATCH /update" do
    it "updates the password" do
      user = User.create(email_address: "email@ok.com", password: "password")
      user.generate_password_reset_token!
      patch password_path(user.password_reset_token), params: { user: { password: "newpassword", password_confirmation: "newpassword" } }
      expect(response).to redirect_to(new_session_path)
      follow_redirect!
      expect(response.body).to include("Password has been reset.")
    end
  end
end
