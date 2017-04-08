require 'rails_helper'

describe 'User Search by Github Endpoint', :type => :request do
  it 'can find users by github username' do
    user = create(:user)

    get "/api/v1/users/by_github?name=#{user.github}"
    found_user = JSON.parse(response.body)
    
    expect(response).to be_success
    expect(found_user["name"]).to eq(user.name)
  end

  it 'returns 404 if no user is found' do
    user = create(:user)

    get '/api/v1/users/by_github?name=not_a_name'
   
    expect(response).to_not be_success
  end
end
