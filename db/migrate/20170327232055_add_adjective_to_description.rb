class AddAdjectiveToDescription < ActiveRecord::Migration[5.0]
  def change

    add_reference :descriptions, :adjective, index: true, foreign_key: true
  end
end
