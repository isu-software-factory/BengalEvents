class ChangeLeadToBeIntegerInTeams < ActiveRecord::Migration[5.2]
  def change
    change_column :teams, :lead, :integer
  end
end
