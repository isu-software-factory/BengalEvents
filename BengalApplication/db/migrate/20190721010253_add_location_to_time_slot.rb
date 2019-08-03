class AddLocationToTimeSlot < ActiveRecord::Migration[5.2]
  def change
    add_reference :time_slots, :location, foreign_key: true
  end
end
