class AddSessionsReferenceToActivities < ActiveRecord::Migration[5.2]
  def change
    add_reference :sessions, :activities, index: true, foreign_key: true
  end
end
