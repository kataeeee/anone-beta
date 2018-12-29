class RemoveLoverToBasics < ActiveRecord::Migration[5.2]
  def change
    remove_column :basics, :b_lover_attribute, :string
  end
end
