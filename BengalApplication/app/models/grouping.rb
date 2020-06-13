# == Schema Information
#
# Table name: groupings
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  student_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Grouping < ApplicationRecord
  belongs_to :team
  belongs_to :user
end
