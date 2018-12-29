class AddResultsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :romantic_result, :string
    add_column :users, :sexual_result, :string
    add_column :users, :appearance_result, :string
  end
end
