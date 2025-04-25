require 'rails_helper'

RSpec.describe Friendship, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:friend_id) }
  end
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:friend).class_name('User') }
  end
  describe "database columns" do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:friend_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end
  describe "indexes" do
    it { should have_db_index(:user_id) }
    it { should have_db_index(:friend_id) }
  end
  describe "uniqueness" do
    it { should validate_uniqueness_of(:user_id).scoped_to(:friend_id) }
    it { should validate_uniqueness_of(:friend_id).scoped_to(:user_id) }
  end
  describe "friendship creation" do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }

    it "creates a friendship" do
      friendship = Friendship.create(user: user, friend: friend)
      expect(friendship).to be_valid
      expect(friendship.user).to eq(user)
      expect(friendship.friend).to eq(friend)
    end

    it "does not allow duplicate friendships" do
      Friendship.create(user: user, friend: friend)
      duplicate_friendship = Friendship.new(user: user, friend: friend)
      expect(duplicate_friendship).not_to be_valid
    end
  end
end
