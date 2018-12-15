class CreateBasics < ActiveRecord::Migration[5.2]
  def change
    create_table :basics do |t|
      t.integer :user_id
      t.integer :q1_sex
      t.integer :q2_sexual_orientation
      t.integer :q3_gender
      t.integer :q4_partner
      t.integer :q5_sexual_experience

      t.timestamps
    end
  end
end
