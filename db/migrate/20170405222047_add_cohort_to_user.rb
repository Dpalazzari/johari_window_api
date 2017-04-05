class AddCohortToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :cohort, foreign_key: true, index: true
  end
end
