class CreateSession < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :capacity
      add_reference :sessions, :activities, index: true, foreign_key: true

      t.timestamps
    end
  end
end
