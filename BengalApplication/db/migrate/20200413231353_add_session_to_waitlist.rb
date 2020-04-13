class AddSessionToWaitlist < ActiveRecord::Migration[5.2]
  def change
    add_reference :waitlists, :session, index: true, foreign_key: true
  end
end
