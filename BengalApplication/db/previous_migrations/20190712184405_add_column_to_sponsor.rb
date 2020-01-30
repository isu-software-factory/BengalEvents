class AddColumnToSponsor < ActiveRecord::Migration[5.2]
  def change
    add_column :sponsors, :name, :string
  end
end
