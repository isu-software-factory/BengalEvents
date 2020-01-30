class CreateActivityType < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_types do |t|
      t.boolean :isMakeAhead
      t.boolean :isCompetetion
      t.timestamps
    end
  end
end
