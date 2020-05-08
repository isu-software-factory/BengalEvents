class CreateSetup < ActiveRecord::Migration[5.2]
  def change
    create_table :setups do |t|
      t.boolean :configure, default: false
      t.timestamps
    end
  end
end
