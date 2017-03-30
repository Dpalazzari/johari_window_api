class Assignment < ApplicationRecord
  # User assigned to do the describing
  belongs_to :assignee, class_name: "User"
  # User assigned to be desribed
  belongs_to :assigned, class_name: "User"

  def self.complete(describee_id, describer_id)
    assignment   = where("assignee_id = ? AND assigned_id = ?", 
                          describer_id, describee_id).first
    assignment.update(completed?: true)
    assignment.save
  end

  def self.invalid?(describee_id, describer_id)
    Assignment.where('assignee_id' => describer_id, 'assigned_id' => describee_id, 'completed?' => false).empty?
  end
end
