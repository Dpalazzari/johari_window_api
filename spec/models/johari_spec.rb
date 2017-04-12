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

  describe 'formatting descriptions' do

    let(:arena_adj)   { create(:adjective, name: 'arena') }
    let(:facade_adj)  { create(:adjective, name: 'facade') }
    let(:blind_adj)   { create(:adjective, name: 'blind') }
    let(:unknown_adj) { create(:adjective, name: 'unknown') }

    before do 
      describer = create(:user)
      create_list(:description, 7, describee: user, describer: user, adjective: arena_adj)
      create_list(:description, 4, describee: user, describer: describer, adjective: arena_adj)
      create_list(:description, 3, describee: user, describer: user, adjective: facade_adj)
      create_list(:description, 6, describee: user, describer: describer, adjective: blind_adj)
      create(:description, adjective: unknown_adj)
    end

    describe '#arena_adjectives' do
      it 'returns adjectives' do

        expect(johari.arena_adjectives).to eq [arena_adj] * 4
      end
    end

    describe '#facade_adjectives' do
      it 'returns adjectives' do

        expect(johari.facade_adjectives).to eq [facade_adj] * 3
      end
    end

    describe '#blind_spot_adjectives' do
      it 'returns adjectives' do

        expect(johari.blind_spot_adjectives).to eq [blind_adj] * 6
      end
    end

    describe '#unknown_adjectives' do
      it 'returns adjectives' do

        expect(johari.unknown_adjectives).to eq [unknown_adj]
      end
    end

    describe '#window_with_freq' do
      context 'with arena adjectives' do
        it 'returns window' do
          expected = [{ 'name': arena_adj.name, 'frequency': 6.0}]
          result = johari.window_with_freq(johari.arena_adjectives)

          expect(result).to eq expected
        end
      end

      context 'blind spot adjectives' do
        it 'with returns window' do
          expected = [{ 'name': blind_adj.name, 'frequency': 9.0 }]
          result = johari.window_with_freq(johari.blind_spot_adjectives)

          expect(result).to eq expected
        end
      end
    end

    describe '#window' do
      context 'with unknown adjectives'
        it 'returns window' do
          expected = [{ 'name': unknown_adj.name, 'frequency': 1 }]
          result = johari.window(johari.unknown_adjectives)

          expect(result).to eq expected
        end

      context 'with facade adjectives' do
        it 'returns window' do
          expected = [{ 'name': facade_adj.name, 'frequency': 1 }]
          result = johari.window(johari.facade_adjectives)

          expect(result).to eq expected
        end
      end
    end

    describe '#arena_window' do
      it 'returns arena window with frequencies' do
        expected = johari.window_with_freq(johari.arena_adjectives)

        expect(johari.arena_window).to eq expected
      end
    end

    describe '#facade_window' do
      it 'returns blind spot window with frequencies' do
        expected = johari.window(johari.facade_adjectives)

        expect(johari.facade_window).to eq expected
      end
    end

    describe '#blind_spot_window' do
      it 'returns blind spot window without frequencies' do
        expected = johari.window_with_freq(johari.blind_spot_adjectives)

        expect(johari.blind_spot_window).to eq expected
      end
    end

    describe '#unknown_window' do
      it 'returns blind spot window without frequencies' do
        expected = johari.window(johari.unknown_adjectives)

        expect(johari.unknown_window).to eq expected
      end
    end

    describe '#format_descriptions' do
      it 'returns hash with keys as four window quadrants' do
        expected = Hash.new(0)
        expected["arena"]      = johari.arena_window
        expected["facade"]     = johari.facade_window
        expected["blind-spot"] = johari.blind_spot_window
        expected["unknown"]    = johari.unknown_window

        expect(johari.format_descriptions).to eq expected
      end
    end
  end
end