class CreateEventDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :event_details do |t|
      t.integer :capacity
      t.datetime :start_time
      t.datetime :end_time
      t.references :event, index: true, foreign_key: true

      t.timestamps
    end
  end
end
