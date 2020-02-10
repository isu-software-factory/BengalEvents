class CreateTeamRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :team_registrations do |t|
      t.references :team, foreign_key: true
      t.references :session, foreign_key: true
      t.timestamps
    end
  end
end
