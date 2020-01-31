class AddEventsReferenceToActivities < ActiveRecord::Migration[5.2]
  def change
    add_reference :activities, :event, index: true, foreign_key: true
  end
end
