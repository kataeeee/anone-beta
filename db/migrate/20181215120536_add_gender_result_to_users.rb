class AddGenderResultToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender_result, :string
  end
end
