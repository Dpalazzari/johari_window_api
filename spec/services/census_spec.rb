require 'rails_helper'

describe 'Census service' do
  context '.get_token' do
    it 'returns an access token', vcr: true do
      token = CensusService.get_token

      expect(token).to be_a String
    end
  end

  context '.get_cohort_by_github', vcr: true do
    it 'returns cohort name' do
      cohort = CensusService.get_cohort_by_github('kheppenstall')

      expect(cohort).to be_a String
      expect(cohort).to eq '1610-BE'
    end
  end
end