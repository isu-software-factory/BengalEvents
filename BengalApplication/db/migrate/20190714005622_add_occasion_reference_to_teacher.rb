class AddOccasionReferenceToTeacher < ActiveRecord::Migration[5.2]
  def change
    add_reference :teachers, :occasion, index: true, foreign_key: true
  end
end
