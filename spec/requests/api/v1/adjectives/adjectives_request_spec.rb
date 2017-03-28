require 'rails_helper'

describe "Adjectives Endpoint", type: :request do
  describe 'get /api/v1/adjectives' do
    it 'returns json of all adjectives' do
      create_list(:adjective, 4)
      get '/api/v1/adjectives'
      
      expect(response).to be_success

      raw_adjectives = JSON.parse(response.body)

      expect(raw_adjectives.count).to eq(4)
      expect(raw_adjectives).to be_a(Array)
    end
  end
end