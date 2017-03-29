require 'rails_helper'

RSpec.describe Assignment, type: :model do
  describe 'relationships' do
    it { should belong_to(:assignee) }
    it { should belong_to(:assigned) }
  end

  describe 'methods' do
    it '.complete' do
      user1, user2 = create_list(:user, 2)
      assignment = create(:assignment, assignee: user2, assigned: user1)
      
      Assignment.complete(user1.id, user2.id)
      assignment.reload

      expect(assignment.completed?).to be_truthy
    end
  end
end
