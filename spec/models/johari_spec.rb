require 'rails_helper'

RSpec.describe Johari, type: :model do

  let(:user) { create(:user) }
  let(:johari) { Johari.new(user) }

  describe '#user' do
    it 'returns user object' do
      
      expect(johari.user).to eq user
    end
  end

  describe 'described adjectives' do
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

  describe '#get_frequency' do
    it 'returns fraction of times an adjective was selected' do
      adjective = create(:adjective)
      create_list(:description, 3, describee: user, adjective: adjective)
      create_list(:description, 1, describee: user)

      expect(johari.get_frequency(adjective)).to eq 0.75
    end
  end

  describe 'formatting descriptions' do

    let(:arena_adj)   { create(:adjective, name: 'arena') }
    let(:facade_adj)  { create(:adjective, name: 'facade') }
    let(:blind_adj)   { create(:adjective, name: 'blind') }
    let(:unknown_adj) { create(:adjective, name: 'unknown') }

    before do 
      create(:description, describee: user, describer: user, adjective: arena_adj)
      create(:description, describee: user, adjective: arena_adj)
      create(:description, describee: user, describer: user, adjective: facade_adj)
      create(:description, describee: user, adjective: blind_adj)
    end

    describe '#create_window' do
      it 'maps adjectives to hash with name and frequency' do
        expected= [{ 'name': arena_adj.name, 'frequency': 0.5 }]
        window = johari.create_window([arena_adj])
        expect(window).to eq expected
      end
    end

    describe '#arena' do
      it 'returns window of self described and peer described' do
        expected = johari.create_window([arena_adj])

        expect(johari.arena).to eq expected
      end
    end

    describe '#facade' do
      it 'returns window of self described and peer described' do
        expected = johari.create_window([facade_adj])

        expect(johari.facade).to eq expected
      end
    end

    describe '#blind_spot' do
      it 'returns window of self described and peer described' do
        expected = johari.create_window([blind_adj])

        expect(johari.blind_spot).to eq expected
      end
    end

    describe '#unknown' do
      it 'returns window of self described and peer described' do
        expected = johari.create_window([unknown_adj])

        expect(johari.unknown).to eq expected
      end
    end

    describe '#format_descriptions' do
      it 'returns hash with keys as four window quadrants' do
        expected = Hash.new(0)
        expected['arena']      = johari.arena
        expected['facade']     = johari.facade
        expected['blind-spot'] = johari.blind_spot
        expected['unknown']    = johari.unknown

        expect(johari.format_descriptions).to eq expected
      end
    end
  end
end