class CreatePeriods < ActiveRecord::Migration[5.2]
  def change
    create_table :periods do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :capacity
      t.references :event, index: true, foreign_key: true

      t.timestamps
    end
  end
end
