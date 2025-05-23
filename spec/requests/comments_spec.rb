require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "POST /comments" do
    it "creates a comment" do
      post comments_path, params: { comment: { content: "This is a test comment." } }
      expect(response).to redirect_to(comments_path)
      follow_redirect!
      expect(response.body).to include("Comment was successfully created.")
    end
  end

  describe "DELETE /comments/:id" do
    let!(:comment) { Comment.create(content: "This is a test comment.") }

    it "deletes a comment" do
      delete comment_path(comment)
      expect(response).to redirect_to(comments_path)
      follow_redirect!
      expect(response.body).to include("Comment was successfully destroyed.")
    end
  end
end
