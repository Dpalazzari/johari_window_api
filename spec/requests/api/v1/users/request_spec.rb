require 'rails_helper'

describe 'User endpoint', type: :request do
  describe "GET /api/v1/users/:id" do
    it "returns json for user by :id" do
      user  = create(:user, name: 'Annie')
      user2 = create(:user, name: 'Drew')

      get "/api/v1/users/#{user.id}"

      expect(response).to be_success

      raw_user = JSON.parse(response.body)
      expect(raw_user['name']).to eq(user.name)
      expect(raw_user['name']).to_not eq(user2.name)
    end
  end
end