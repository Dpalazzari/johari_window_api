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
    it { should belong_to :cohort }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :github }
    it { is_expected.to validate_presence_of :token } 
    it { is_expected.to validate_uniqueness_of :github } 
    it { is_expected.to validate_uniqueness_of :token }  
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

    it '.create_descriptions' do
      user, user2 = create_list(:user, 2)
      descriptions = ['shy', 'religious']
      create(:adjective, name: 'shy')
      create(:adjective, name: 'religious')

      user.create_descriptions(descriptions, user2)

      expect(user.descriptions.count).to eq(2)
    end

    it '.all_descriptions_completed?' do
      user, user2 = create_list(:user, 2)
      descriptions = ['shy', 'religious']
      create(:adjective, name: 'shy')
      create(:adjective, name: 'religious')

      user.create_descriptions(descriptions, user2)
      result = user.all_descriptions_completed?(user2.id, descriptions)

      expect(result).to be_truthy
    end
  end
end
