class AddUpdateAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :benchpress_update, :datetime, null: false, default: -> { 'NOW()' }
    add_column :users, :squat_update, :datetime,null: false, default: -> { 'NOW()' }
    add_column :users, :deadlift_update, :datetime, null: false, default: -> { 'NOW()' }
  end
end
