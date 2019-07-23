class AddMemberToParticipants < ActiveRecord::Migration[5.2]
  def change
    add_column :participants, :member_id, :integer
    add_column :participants, :member_type, :string
  end
end
