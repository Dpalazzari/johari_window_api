class CreateAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :assignments do |t|
      t.integer :status, default: 0
      t.integer :assignee_id
      t.integer :assigned_id

      t.timestamps
    end

    add_foreign_key :assignments, :users, index: true, column: :assignee_id
    add_foreign_key :assignments, :users, index: true, column: :assigned_id
  end
end
