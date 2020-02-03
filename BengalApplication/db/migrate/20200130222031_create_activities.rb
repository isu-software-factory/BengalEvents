class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :description
      t.string :equipment
      t.boolean :ismakeahead
      t.boolean :iscompetetion
      t.timestamps
    end
  end
end