class AddUniqueConstraintOnRegistration < ActiveRecord::Migration[5.2]
  def change
    add_index :registrations, [:event_detail_id, :participant_id], unique: true
  end
end
