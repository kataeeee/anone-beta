class CreateSexuals < ActiveRecord::Migration[5.2]
  def change
    create_table :sexuals do |t|
      t.integer :s_1
      t.integer :s_2
      t.integer :s_3
      t.integer :s_4
      t.integer :s_5
      t.integer :s_6
      t.integer :s_7
      t.integer :s_8
      t.integer :s_9
      t.integer :s_10
      t.integer :s_11
      t.integer :s_12

      t.timestamps
    end
  end
end
