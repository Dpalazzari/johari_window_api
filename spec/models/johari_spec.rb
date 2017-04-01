require 'rails_helper'

RSpec.describe Johari, type: :model do

  let(:user) { create(:user) }
  let(:johari) { Johari.new(user) }

  describe '#user' do
    it 'returns user object' do
      
      expect(johari.user).to eq user
    end
  end

  describe 'descriptions' do
    before do
      create_list(:description, 3, describer: user, describee: user)
      create_list(:description, 2, describee: user)
      create_list(:description, 1, describer: user)
    end

    describe '#self_described' do
      it 'returns all adjectives from self descriptions' do
        
        expect(johari.self_described.count).to eq 3
      end
    end

    describe '#peer_described' do
      it 'returns all adjectives from self descriptions' do
        
        expect(johari.peer_described.count).to eq 2
      end
    end
  end

  describe '#johari' do
    it 'initializes as an empty hash' do

      expect(johari.johari).to eq Hash.new(0)
    end
  end
end