require 'rails_helper'

describe 'Census service' do
  context '.get_token' do
    it 'returns an access token', vcr: true do
      token = CensusService.get_token

      expect(token).to be_a String
    end
  end
end