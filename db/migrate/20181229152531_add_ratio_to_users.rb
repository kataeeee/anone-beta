class AddRatioToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ratio_gender, :integer
    add_column :users, :ratio_romantic_1, :integer
    add_column :users, :ratio_romantic_2, :integer
    add_column :users, :ratio_sexual_1, :integer
    add_column :users, :ratio_sexual_2, :integer
    add_column :users, :ratio_appearance, :integer
  end
end
