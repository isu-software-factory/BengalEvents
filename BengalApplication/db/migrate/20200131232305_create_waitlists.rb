class CreateWaitlists < ActiveRecord::Migration[5.2]
  def change
    create_table :waitlists do |t|
      t.belongs_to :session
      t.timestamps
    end
  end
end
