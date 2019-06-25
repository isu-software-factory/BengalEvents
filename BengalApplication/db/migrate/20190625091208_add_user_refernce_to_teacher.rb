class AddUserRefernceToTeacher < ActiveRecord::Migration[5.2]
  def change
    add_reference :teachers, :user, index: true, foreign_key: true
  end
end
