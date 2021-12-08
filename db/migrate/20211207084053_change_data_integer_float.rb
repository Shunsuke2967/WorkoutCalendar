class ChangeDataIntegerFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :users,:squat, :float
    change_column :users,:benchpress, :float
    change_column :users,:deadlift, :float
  end
end
