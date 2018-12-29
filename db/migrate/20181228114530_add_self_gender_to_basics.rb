class AddSelfGenderToBasics < ActiveRecord::Migration[5.2]
  def change
    add_column :basics, :q_self_gender, :string
  end
end
