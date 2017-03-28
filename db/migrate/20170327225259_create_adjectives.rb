class CreateAdjectives < ActiveRecord::Migration[5.0]
  def change
    create_table :adjectives do |t|
      t.string :name

      t.timestamps
    end
    add_index :adjectives, :name
  end
end
