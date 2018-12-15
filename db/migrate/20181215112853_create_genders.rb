class CreateGenders < ActiveRecord::Migration[5.2]
  def change
    create_table :genders do |t|
      t.integer :user_id
      t.integer :q6_gender_fitting
      t.integer :q7_body_fitting
      t.integer :q8_favorite_dress
      t.integer :q9_choose_middle
      t.integer :q10_personal_time
      t.integer :q11_sensibility
      t.integer :q12_behavior_adjusting
      t.integer :q13_group_comfort

      t.timestamps
    end
  end
end
