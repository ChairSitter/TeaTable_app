require 'rails_helper'

RSpec.describe "Friendships", type: :request do
  describe "GET /index" do
    it "displays the friendships index" do
      get friendships_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("Friendships")
    end
  end
end
