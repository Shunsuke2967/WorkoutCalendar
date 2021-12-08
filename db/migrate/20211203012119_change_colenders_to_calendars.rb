class ChangeColendersToCalendars < ActiveRecord::Migration[5.2]
  def change
    rename_table :colenders, :calendars
  end
end
