class RemoveIntervalFromTimeSlot < ActiveRecord::Migration[5.2]
  def change
    remove_column :time_slots, :interval, :int
  end
end
