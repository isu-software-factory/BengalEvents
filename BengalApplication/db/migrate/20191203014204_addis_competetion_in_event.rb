class AddisCompetetionInEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :isCompetetion,  :bool
  end
end
