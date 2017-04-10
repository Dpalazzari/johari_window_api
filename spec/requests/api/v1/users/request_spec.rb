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

  describe 'Post /users' do
    it "saves the user to our database" do
      attrs = {user: { name: 'Name', github: 'githubname', token: '1234' }}
      post "/api/v1/users", attrs

      expect(response).to be_success

      raw_user = JSON.parse(response.body)
      expect(raw_user).to be_a(Hash)
      expect(raw_user['name']).to eq(attrs[:user][:name])
      expect(raw_user['github']).to eq(attrs[:user][:github])
      expect(raw_user['token']).to eq(attrs[:user][:token])
      expect(User.count).to eq(1)
    end

    it 'returns an error if not all attributes are provided' do
      invalid_attrs = {user: { github: 'githubname', token: '1234' }}

      post '/api/v1/users', invalid_attrs

      expect(response.status).to eq(400)
    end

    it 'returns a user if the record already exists' do
      user = create(:user)
      user_request = {user: {name: user.name, github: user.github, token: user.token }}
      post '/api/v1/users', user_request

      raw_user = JSON.parse(response.body)
      expect(raw_user['name']).to eq(user.name)
      expect(raw_user['github']).to eq(user.github)
      expect(raw_user['token']).to eq(user.token)
    end
  end
end
