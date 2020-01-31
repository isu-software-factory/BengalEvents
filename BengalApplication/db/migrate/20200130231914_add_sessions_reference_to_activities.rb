class AddSessionsReferenceToActivities < ActiveRecord::Migration[5.2]
  def change
    add_reference :sessions, :activity, index: true, foreign_key: true
  end
end
