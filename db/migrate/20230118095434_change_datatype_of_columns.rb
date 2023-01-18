class ChangeDatatypeOfColumns < ActiveRecord::Migration[7.0]
  def change
    change_column(:medicines, :price, :float)
  end
end
