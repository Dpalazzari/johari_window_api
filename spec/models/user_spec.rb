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
    it { is_expected.to validate_presence_of :role } 
    it { is_expected.to validate_uniqueness_of :github } 
    it { is_expected.to validate_uniqueness_of :token }  
  end

  describe 'role' do
    it 'defaults to student' do
      user = create(:user)

      expect(user.role).to eq 'student'
      expect(user.student?).to be_truthy
    end

    it 'set to staff' do
      user = create(:user, role: 1)

      expect(user.role).to eq 'staff'
      expect(user.staff?).to be_truthy
    end
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

    it '#add_cohort', vcr: true do
      user = create(:user, github: 'kheppenstall')
      user.add_cohort

      expect(user.cohort.name).to eq '1610-BE'
    end
  end
end
