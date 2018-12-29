class AddR12ToRomantics < ActiveRecord::Migration[5.2]
  def change
    remove_column :romantics, :r_12, :string
  end
end
