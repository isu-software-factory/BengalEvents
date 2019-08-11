class AddColumnToEventDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :event_details, :date_started, :date
  end
end
