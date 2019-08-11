class AddColumnToTimeSlots < ActiveRecord::Migration[5.2]
  def change
    add_column :time_slots, :interval, :integer
  end
end
