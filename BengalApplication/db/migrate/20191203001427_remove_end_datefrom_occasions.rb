class RemoveEndDatefromOccasions < ActiveRecord::Migration[5.2]
  def change

      remove_column :occasions, :end_date, :datetime

  end
end
