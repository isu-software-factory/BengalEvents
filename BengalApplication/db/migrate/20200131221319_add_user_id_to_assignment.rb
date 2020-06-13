class AddUserIdToAssignment < ActiveRecord::Migration[5.2]
  def change
    add_reference :assignments, :user, index: true, foreign_key: true
    add_reference :assignments, :role, index: true, foreign_key: true
  end
end
