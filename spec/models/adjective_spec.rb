require 'rails_helper'

RSpec.describe Adjective, type: :model do
  describe 'relationships' do
    it { should have_many :descriptions }
    it { should have_many :users }
  end
end
