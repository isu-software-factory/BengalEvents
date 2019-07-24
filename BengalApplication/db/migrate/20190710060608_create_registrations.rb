class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations do |t|
      t.references :participant, foreign_key: true
      t.references :event_detail, foreign_key: true

      t.timestamps
    end
  end
end
