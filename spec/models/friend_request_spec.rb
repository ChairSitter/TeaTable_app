require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "validations" do
    it { should validate_presence_of(:sender_id) }
    it { should validate_presence_of(:receiver_id) }
    it { should validate_inclusion_of(:status).in_array(%w[pending accepted rejected]) }
  end
  describe "associations" do
    it { should belong_to(:sender).class_name('User') }
    it { should belong_to(:receiver).class_name('User') }
  end
  describe "database columns" do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:sender_id).of_type(:integer) }
    it { should have_db_column(:receiver_id).of_type(:integer) }
    it { should have_db_column(:status).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end
  describe "indexes" do
    it { should have_db_index(:sender_id) }
    it { should have_db_index(:receiver_id) }
  end
end
