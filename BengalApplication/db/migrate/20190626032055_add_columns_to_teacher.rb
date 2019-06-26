class AddColumnsToTeacher < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :chaperone_count, :integer
    add_column :teachers, :student_count, :integer
  end
end
