class CreateEvent < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.datetime :start_date
      t.string :name
      t.string :description
      t.boolean :visible, default: false
      t.datetime :visible_constraint
      t.timestamps
    end
  end
end
