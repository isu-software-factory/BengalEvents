class AddEventDetailReferenceToWaitlist < ActiveRecord::Migration[5.2]
  def change
    add_reference :waitlists, :event_detail, index: true, foreign_key: true
  end
end
