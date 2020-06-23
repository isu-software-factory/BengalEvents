class AddRoomsReferenceToSessions < ActiveRecord::Migration[5.2]
  def change
    add_reference :sessions, :room, index: true, foreign_key: true
  end
end
