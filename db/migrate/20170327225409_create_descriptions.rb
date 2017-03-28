class CreateDescriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :descriptions do |t|
      t.integer :describer_id
      t.integer :describee_id

      t.timestamps
    end

    add_foreign_key :descriptions, :users, index: true, column: :describer_id
    add_foreign_key :descriptions, :users, index: true, column: :describee_id
  end
end
