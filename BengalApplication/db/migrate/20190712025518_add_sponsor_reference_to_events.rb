class AddSponsorReferenceToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :sponsor, index: true, foreign_key: true
  end
end
