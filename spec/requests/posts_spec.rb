require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "POST /create" do
    it "creates a post" do
      post posts_path, params: { post: { title: "Test Post", content: "This is a test post." } }
      expect(response).to redirect_to(posts_path)
      follow_redirect!
      expect(response.body).to include("Post was successfully created.")
    end
  end
  describe "GET /index" do
    it "dispays the posts index" do
      get posts_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("Posts")
    end
  end
end
