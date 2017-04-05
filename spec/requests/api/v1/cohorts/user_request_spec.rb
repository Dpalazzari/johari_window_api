require 'rails_helper'

describe 'Cohorts Users', type: :request do
  describe 'Get /api/v1/cohorts/:id/users' do
    it 'returns json of a specific cohorts users' do
      cohort = create(:cohort)
      create_list(:user, 10, cohort: cohort)
      create_list(:user, 5)

      get "/api/v1/cohorts/#{cohort.id}/users"

      expect(response).to be_success

      raw_users = JSON.parse(response.body)
      expect(raw_users).to be_an(Array)
      expect(raw_users.count).to eq(10)
      raw_users.each do |user|
        expect(user['cohort_id']).to eq(cohort.id)
      end
    end
  end
end