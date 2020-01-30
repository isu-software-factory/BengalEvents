class AddDefaultValueToMakeAhead < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :isMakeAhead, :boolean, default: false
  end

end
