require 'rails_helper'

describe 'Users Descriptions Endpoint' do
  it "post /api/v1/users/:id/descriptions" do
    user1, user2 = create_list(:user, 2)
    create(:assignment, assignee: user1, assigned: user2)
    
    expect(user2.descriptions.count).to eq(0)
    adjectives = ["shy", "religous", "cool"]
    # conn = Faraday.new(:url => ) do |faraday|
    #   faraday.adapter Faraday.default_adapter
    # end

    post "/api/v1/users/#{user2.id}/descriptions", { :format => :json, :description => adjectives }
    
    expect(response).to be_success

    raw_status = JSON.parse(response.body)
    
    expect(raw_status).to be(202)
    expect(user2.descriptions.count).to eq(1)
  end
end