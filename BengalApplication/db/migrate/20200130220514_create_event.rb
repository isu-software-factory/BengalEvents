class CreateEvent < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.datetime :start_date
      t.string :name
      t.string :description
      t.boolean :visible
      t.timestamps
    end
  end
end
