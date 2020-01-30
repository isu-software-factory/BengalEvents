class AddOccasionIdToEvent < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :occasion, index: true, foreign_key: true
  end
end
