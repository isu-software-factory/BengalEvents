class AddCoordinatorReferenceToOccasion < ActiveRecord::Migration[5.2]
  def change
    add_reference :occasions, :coordinator, index: true, foreign_key: true
  end
end
