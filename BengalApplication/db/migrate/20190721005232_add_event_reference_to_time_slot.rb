class AddEventReferenceToTimeSlot < ActiveRecord::Migration[5.2]
  def change
    add_reference :time_slots, :event, foreign_key: true
  end
end
