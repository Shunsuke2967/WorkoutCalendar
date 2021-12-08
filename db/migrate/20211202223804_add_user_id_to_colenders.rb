class AddUserIdToColenders < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM colenders;'
    add_reference :colenders, :user, null: false, index: true
  end

  def down
    remove_reference :colenders, :user, index: true
  end
end
