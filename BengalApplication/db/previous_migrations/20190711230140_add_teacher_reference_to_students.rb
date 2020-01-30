class AddTeacherReferenceToStudents < ActiveRecord::Migration[5.2]
  def change
    add_reference :students, :teacher, index: true, foreign_key: true
  end
end
