require 'rails_helper'

describe 'Cohorts Index', type: :request do
  describe 'get /api/v1/cohorts' do
    it 'returns json of a list of names of all cohorts' do
      cohorts = create_list(:cohort, 8)
      expect(Cohort.count).to eq(8)
      get '/api/v1/cohorts'

      expect(response).to be_success

      raw_cohorts = JSON.parse(response.body)
      expect(raw_cohorts).to be_an(Array)
      expect(raw_cohorts.count).to eq(8)
    end
  end
end