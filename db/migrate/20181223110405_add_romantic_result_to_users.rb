class AddRomanticResultToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :romantic_result_1, :string
    add_column :users, :romantic_result_2, :string
  end
end
