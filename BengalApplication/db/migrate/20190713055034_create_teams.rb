class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :lead
      t.string :team_name
      t.belongs_to :waitlist
      t.timestamps
    end
  end
end
