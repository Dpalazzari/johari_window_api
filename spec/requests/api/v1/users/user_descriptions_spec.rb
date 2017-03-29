require 'rails_helper'

describe 'Users Descriptions Endpoint', :type => :request do
  it "post /api/v1/users/:id/descriptions" do
    user1, user2 = create_list(:user, 2)
    create(:assignment, assignee: user1, assigned: user2)
    
    expect(user2.descriptions.count).to eq(0)

    adjectives = ['shy', 'religious', 'cool']
    headers = { 'CONTENT_TYPE' => 'application/json' }
    json = {:johari => adjectives }

    post "/api/v1/users/#{user2.id}/descriptions", json.to_json, headers
        
    expect(response).to be_success

    raw_status = JSON.parse(response.body)
    
    expect(raw_status).to be(202)
    expect(user2.descriptions.count).to eq(1)
  end
end