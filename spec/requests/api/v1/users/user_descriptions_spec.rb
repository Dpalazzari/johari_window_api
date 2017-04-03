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

  it "post /api/v1/users/:id/descriptions sad_path" do
    user1, user2 = create_list(:user, 2)
    assignment = create(:assignment, assignee: user1, assigned: user2)
    
    expect(user2.descriptions.count).to eq(0)

    headers = { 'CONTENT_TYPE' => 'application/json' }
    json = {:johari => [], :describer_id => user1.id }

    post "/api/v1/users/#{user2.id}/descriptions", json.to_json, headers
    
    expect(response).to_not be_success
    
    expect(response.status).to be(304)
    expect(user2.descriptions.count).to eq(0)
    expect(assignment.completed?).to be_falsey
  end

  it 'Posts /api/v1/users/:id/descriptions already_exists_sad_path' do
    user  = create(:user, name: 'Barric Donderrion')
    user2 = create(:user, name: 'Cersei')

    assignment = create(:assignment, assignee: user, assigned: user2, completed?: true)

    adjectives = ['shy', 'religious', 'cool']
    headers = { 'CONTENT_TYPE' => 'application/json' }
    json = {:johari => adjectives, :describer_id => user2.id }

    post "/api/v1/users/#{user.id}/descriptions", json.to_json, headers
    assignment.reload

    expect(response).to_not be_success
    expect(response.status).to eq(401)
  end

  it "get /api/v1/users/:id/descriptions" do
    user1, user2, user3 = create_list(:user, 3)
    assignment1 = create(:assignment, assignee: user3, assigned: user1)
    assignment2 = create(:assignment, assignee: user2, assigned: user1)
    create(:adjective, name: "shy")
    create(:adjective, name: "witty")
    create(:adjective, name: "able")
    create(:adjective, name: "religious")
    create(:description, describee: user1, describer: user1, adjective_id: Adjective.last.id)
    create(:description, describee: user1, describer: user1, adjective_id: Adjective.second_to_last.id)
    create(:description, describee: user1, describer: user2, adjective_id: Adjective.last.id) 
    create(:description, describee: user1, describer: user2, adjective_id: Adjective.first.id) 
    create(:description, describee: user1, describer: user3, adjective_id: Adjective.last.id) 
    
    get "/api/v1/users/#{user1.id}/descriptions"

    raw_descriptions = JSON.parse(response.body)
    expect(response).to be_success
    expect(raw_descriptions['arena'].count).to eq(1)
    expect(raw_descriptions['arena'].first['name']).to eq('religious')
    expect(raw_descriptions['facade'].count).to eq(1)
    expect(raw_descriptions['facade'].first['name']).to eq('able')
    expect(raw_descriptions['blind-spot'].count).to eq(1)
    expect(raw_descriptions['blind-spot'].first['name']).to eq('shy')
    expect(raw_descriptions['unknown'].count).to eq(1)
    expect(raw_descriptions['unknown'].first['name']).to eq('witty')
  end
end
