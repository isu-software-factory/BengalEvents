class AddUserReferenceToStudent < ActiveRecord::Migration[5.2]
  def change
    add_reference :students, :user, index: true, foreign_key: true
  end
end
