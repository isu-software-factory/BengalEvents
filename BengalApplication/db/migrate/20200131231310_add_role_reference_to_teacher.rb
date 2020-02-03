class AddRoleReferenceToTeacher < ActiveRecord::Migration[5.2]
  def change
    add_reference :teachers, :role, index: true, foreign_key: true

  end
end
