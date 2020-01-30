class AddColumnToOccasion < ActiveRecord::Migration[5.2]
  def change
    add_column :occasions, :description, :string
  end
end
