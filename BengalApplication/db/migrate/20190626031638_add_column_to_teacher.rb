class AddColumnToTeacher < ActiveRecord::Migration[5.2]
  def change
    add_column :teachers, :school, :string
  end
end
