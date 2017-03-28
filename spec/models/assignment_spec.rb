require 'rails_helper'

RSpec.describe Assignment, type: :model do
  describe 'relationships' do
    it { should belong_to(:assignee) }
    it { should belong_to(:assigned) }
  end
end
