class AddForeignKeyToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_details, :user, foreign_key: true, null: true
  end
end
