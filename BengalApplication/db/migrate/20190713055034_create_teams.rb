class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :lead
      t.name :team_name
      t.timestamps
    end
  end
end
