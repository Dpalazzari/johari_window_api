require 'rails_helper'

describe 'Users Descriptions Endpoint', :type => :request do
  it "post /api/v1/users/:id/descriptions" do
    create(:adjective, name: 'shy')
    create(:adjective, name: 'religious')
    create(:adjective, name: 'cool')
    user1, user2 = create_list(:user, 2)
    assignment = create(:assignment, assignee: user1, assigned: user2)
    
    expect(user2.descriptions.count).to eq(0)

    adjectives = ['shy', 'religious', 'cool']
    headers = { 'CONTENT_TYPE' => 'application/json' }
    json = {:johari => adjectives, :describer_id => user1.id }

    post "/api/v1/users/#{user2.id}/descriptions", json.to_json, headers
    assignment.reload
    
    expect(response).to be_success
    
    expect(response.status).to be(202)
    expect(user2.descriptions.count).to eq(3)
    expect(assignment.completed?).to be_truthy
  end
end