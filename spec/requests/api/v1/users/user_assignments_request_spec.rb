require 'rails_helper'

describe "User Assignments Endpoint", type: :request do
  describe "get /api/v1/users/:id/assignments" do
    it "returns json with all the users assigned to one user and the assignment status" do
      user = create(:user)
      create_list(:assignment, 5, assignee: user)
      get "/api/v1/users/#{user.id}/assignments"

      expect(response).to be_success

      raw_assignments = JSON.parse(response.body)

      expect(raw_assignments.count).to eq(5)
      expect(raw_assignments.first).to have_key("user")
      expect(raw_assignments.first).to have_key("completed?")
    end 
  end
end