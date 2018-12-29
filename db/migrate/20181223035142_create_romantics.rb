class CreateRomantics < ActiveRecord::Migration[5.2]
  def change
    create_table :romantics do |t|
      t.integer :user_id
      t.integer :r_1
      t.integer :r_2
      t.integer :r_3
      t.integer :r_4
      t.integer :r_5
      t.integer :r_6
      t.integer :r_7
      t.integer :r_8
      t.integer :r_9
      t.integer :r_10
      t.integer :r_11
      t.integer :r_12
      t.integer :r_13
      t.integer :r_14
      t.integer :r_15
      t.integer :r_16

      t.timestamps
    end
  end
end
