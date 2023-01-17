class AddForeignKeyToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :user_detail, foreign_key: true
  end
end
