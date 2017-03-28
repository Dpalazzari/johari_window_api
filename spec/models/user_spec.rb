require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :descriptions }
    it { should have_many :adjectives }
    it { should have_many :described_by }
    it { should have_many :described }
    it { should have_many :described_users }
    it { should have_many :assignments }
    it { should have_many :users_to_describe }
    it { should have_many :assigned_to }
    it { should have_many :users_described_by }
  end

  describe 'methods' do
    it '.find_assignments_and_users' do
      user = create(:user)
      create_list(:assignment, 2, assignee: user)
      assignment_collection = user.find_assignments_and_users

      expect(assignment_collection).to be_an(Array)
      expect(assignment_collection.length).to eq(2)
      expect(assignment_collection.first).to have_key(:user)
      expect(assignment_collection.first).to have_key(:completed?)
    end
  end
end
