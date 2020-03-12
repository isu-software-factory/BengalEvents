class AddMaxTeamSizeToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :max_team_size, :integer
  end
end
