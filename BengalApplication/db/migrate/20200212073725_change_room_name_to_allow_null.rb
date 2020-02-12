class ChangeRoomNameToAllowNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:rooms, :room_name, true)
  end
end
