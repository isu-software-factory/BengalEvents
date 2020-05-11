class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.string :primary_color
      t.string :secondary_color
      t.string :tertiary_color
      t.string :site_name
      t.timestamps
    end
  end
end
