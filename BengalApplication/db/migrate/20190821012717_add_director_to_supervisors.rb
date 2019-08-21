class AddDirectorToSupervisors < ActiveRecord::Migration[5.2]
  def change
    add_column :supervisors, :director_id, :integer
    add_column :supervisors, :director_type, :string
  end
end
