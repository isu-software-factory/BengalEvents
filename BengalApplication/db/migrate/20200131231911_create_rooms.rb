class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :room_number
      t.string :room_name
      t.belongs_to :location
      t.timestamps
    end
  end
end
