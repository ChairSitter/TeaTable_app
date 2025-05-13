require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /new" do
    it "returns a successful response" do
      get new_post_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("New Post")
    end
  end
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
  describe "GET /show" do
    it "displays a specific post" do
      post = Post.create(title: "Test Post", content: "This is a test post.")
      get post_path(post)
      expect(response).to have_http_status(200)
      expect(response.body).to include("Test Post")
    end
  end
  describe "GET /edit" do
    it "returns a successful response" do
      post = Post.create(title: "Test Post", content: "This is a test post.")
      get edit_post_path(post)
      expect(response).to have_http_status(200)
      expect(response.body).to include("Edit Post")
    end
  end
describe "DELETE /destroy" do
    it "deletes a post" do
      post = Post.create(title: "Test Post", content: "This is a test post.")
      delete post_path(post)
      expect(response).to redirect_to(posts_path)
      follow_redirect!
      expect(response.body).to include("Post was successfully destroyed.")
    end
  end
end
