class AddParticipantReferenceToWaitlist < ActiveRecord::Migration[5.2]
  def change
    add_reference :participants, :waitlist, index: true, foreign_key: true
  end
end
