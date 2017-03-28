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
end
