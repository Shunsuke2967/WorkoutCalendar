class CreateColenders < ActiveRecord::Migration[5.2]
  def change
    create_table :colenders do |t|
      t.string :title, null: false
      t.string :memo
      t.boolean :workouted, default: false, null: false
      t.datetime :start_time

      t.timestamps
    end
  end
end
