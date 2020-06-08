class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.string :primary_color, default: "#6d6e71"
      t.string :secondary_color, default: "#f47920"
      t.string :additional_color, default: "#F69240"
      t.string :font
      t.string :site_name, default: "Bengal Stem Day"
      t.timestamps
    end
  end
end
