require 'rails_helper'

describe 'Assignments API' do

  let(:api)   { '/api/v1/assignments' }
  let(:users) { create_list(:user, 6) }

  context 'as a POST to /assignments' do
    context 'with groups without overlapping members' do
      it 'makes all assignments' do
        groups = groups_without_overlaps(users)

        post api, groups.to_json

        expect(response).to be_success

        users.each do |user|
          expect(user.assignments.count).to eq 3
          expect(user.assigned_to.count).to eq 3
        end
      end
    end

    context 'with groups with overlapping members' do

      let(:groups) { groups_with_overlaps(users) }

      it 'makes all unique assignments' do
        post api, groups.to_json

        expect(response).to be_success

        base_id = User.first.id
        assignment_counts = {0 => 5, 1 => 4, 2 => 3, 3 => 4, 4 => 3, 5 => 3}

        assignment_counts.each do |adder, count|
          user = User.find(base_id + adder)
          expect(user.assignments.count).to eq count
          expect(user.assigned_to.count).to eq count
        end
      end
      
      context 'with some assignments completed' do
        it 'makes new assignments unless assignment exists with completed? false' do
          groups = groups_with_overlaps(users)

          base_id = User.first.id
          assignment_counts = {0 => 5, 1 => 5, 2 => 3, 3 => 4, 4 => 3, 5 => 3}

          create(:assignment, assigned: User.first, assignee: User.second, completed?: true)
          create(:assignment, assigned: User.first, assignee: User.third)

          post api, groups.to_json

          expect(response).to be_success

          assignment_counts.each do |adder, count|
            user = User.find(base_id + adder)
            expect(user.assignments.count).to eq count
          end
        end
      end
    end
  end
end