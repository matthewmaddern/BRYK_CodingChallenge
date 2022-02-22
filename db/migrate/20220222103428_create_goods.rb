class CreateGoods < ActiveRecord::Migration[6.1]
  def change
    create_table :goods do |t|
      t.string :cosignment_id
      t.string :type
      t.string :name
      t.string :source
      t.string :destination
      t.time :entry_time
      t.time :exit_time

      t.timestamps
    end
    add_index :goods, :cosignment_id, unique: true
  end
end
