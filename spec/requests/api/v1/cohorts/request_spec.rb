require 'rails_helper'

describe 'Cohorts Index', type: :request do
  describe 'get /api/v1/cohorts' do
    it 'returns json of a list of names of all cohorts' do
      cohorts = create_list(:cohort, 8)

      get '/api/v1/cohorts'

      expect(response).to be_success

      raw_cohorts = JSON.parse(response.body)
      cohorts.each do |cohort|
        expect(raw_cohorts).to include(cohort.name)
      end
    end
  end
end