class AddSupervisorReferenceToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :supervisor, index: true, foreign_key: true
  end
end
