class ChangeDataMemoToCalender < ActiveRecord::Migration[5.2]
  def change
    change_column :calendars, :memo, :text
  end
end
