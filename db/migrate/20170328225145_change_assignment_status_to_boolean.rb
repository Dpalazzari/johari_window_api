class ChangeAssignmentStatusToBoolean < ActiveRecord::Migration[5.0]
  def change
    remove_column :assignments, :status
    add_column :assignments, :completed?, :boolean, default: false
  end
end
