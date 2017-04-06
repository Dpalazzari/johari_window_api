class AddAttributesToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :github, :string
    add_column :users, :token, :string
  end
end
