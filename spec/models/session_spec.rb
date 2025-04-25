require 'rails_helper'

RSpec.describe Session, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:session_token) }
  end
  describe "associations" do
    it { should belong_to(:user) }
  end
  describe "database columns" do
    it { should have_db_column(:id).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:session_token).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end
  describe "indexes" do
    it { should have_db_index(:user_id) }
    it { should have_db_index(:session_token).unique(true) }
  end
  describe "uniqueness" do
    it { should validate_uniqueness_of(:session_token) }
  end
  describe "session creation" do
    let(:user) { create(:user) }

    it "creates a session" do
      session = Session.create(user: user, session_token: "unique_token")
      expect(session).to be_valid
      expect(session.user).to eq(user)
      expect(session.session_token).to eq("unique_token")
    end

    it "does not allow duplicate session tokens" do
      Session.create(user: user, session_token: "duplicate_token")
      duplicate_session = Session.new(user: user, session_token: "duplicate_token")
      expect(duplicate_session).not_to be_valid
    end
  end
  describe "session deletion" do
    let(:user) { create(:user) }
    let(:session) { create(:session, user: user) }

    it "deletes a session" do
      session_id = session.id
      session.destroy
      expect(Session.find_by(id: session_id)).to be_nil
    end

    it "does not delete other sessions" do
      other_session = create(:session, user: user)
      session.destroy
      expect(Session.find_by(id: other_session.id)).not_to be_nil
    end
  end
end
