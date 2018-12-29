class AddBToBasics < ActiveRecord::Migration[5.2]
  def change
    add_column :basics, :b_type_person, :integer
    add_column :basics, :b_partner_attribute, :string
    add_column :basics, :b_lover_attribute, :string
  end
end
