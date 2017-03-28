class User < ApplicationRecord
  # descriptions about this user
  has_many :descriptions, foreign_key: :describee_id
  # adjectives that apply to this user
  has_many :adjectives, through: :descriptions
  # users that have described this user
  has_many :described_by, through: :descriptions, source: :describee
  
  # descriptions this user has made
  has_many :described, foreign_key: :describer_id, class_name: "Description"
  # users that this user has described
  has_many :described_users, through: :described, source: :describer
  
  # who this user has been assigned to describe
  has_many :assignments, foreign_key: :assignee_id
  has_many :users_to_describe, through: :assignments, source: :assigned
  # who has been assigned to describe this user
  has_many :assigned_to, foreign_key: :assigned_id, class_name: "Assignment"
  has_many :users_described_by, through: :assigned_to, source: :assignee
end
