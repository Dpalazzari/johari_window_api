class RemoveCohortFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :cohort_id
    add_reference :users, :cohort, index: true
  end
end
