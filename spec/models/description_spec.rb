require 'rails_helper'

RSpec.describe Description, type: :model do
  describe 'relationships' do
    it { should belong_to :describer }
    it { should belong_to :describee }
    it { should belong_to :adjective }
  end
end
