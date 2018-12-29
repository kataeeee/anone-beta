class AddSexAttributeToBasics < ActiveRecord::Migration[5.2]
  def change
    add_column :basics, :b_sex_attribute, :string
  end
end
