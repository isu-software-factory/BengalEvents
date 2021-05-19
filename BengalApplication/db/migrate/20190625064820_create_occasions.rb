class CreateOccasions < ActiveRecord::Migration[5.2]
  def change
    create_table :occasions do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end