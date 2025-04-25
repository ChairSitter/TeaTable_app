require 'rails_helper'

RSpec.describe Post, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user_id) }
  end
  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end
  describe "database columns" do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:content).of_type(:text) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end
  describe "indexes" do
    it { should have_db_index(:user_id) }
  end
  describe "uniqueness" do
    it { should validate_uniqueness_of(:title).scoped_to(:user_id) }
  end
  describe "post creation" do
    let(:user) { create(:user) }

    it "creates a post" do
      post = Post.create(user: user, title: "Sample Title", content: "Sample Content")
      expect(post).to be_valid
      expect(post.user).to eq(user)
      expect(post.title).to eq("Sample Title")
      expect(post.content).to eq("Sample Content")
    end

    it "does not allow duplicate titles for the same user" do
      Post.create(user: user, title: "Unique Title", content: "Content")
      duplicate_post = Post.new(user: user, title: "Unique Title", content: "Different Content")
      expect(duplicate_post).not_to be_valid
    end
  end
  describe "post deletion" do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }
  end
end
