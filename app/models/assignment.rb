class Assignment < ApplicationRecord
  # User assigned to do the describing
  belongs_to :assignee, class_name: "User"
  # User assigned to be desribed
  belongs_to :assigned, class_name: "User"

  enum status: %w(open closed)
end
