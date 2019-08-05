class AddLocationToEventDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :event_details, :location, :string
  end
end
