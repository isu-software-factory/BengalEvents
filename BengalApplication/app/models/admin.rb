# == Schema Information
#
# Table name: admins
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Admin < ApplicationRecord
  has_one :user, as: :meta, dependent: :destroy
  accepts_nested_attributes_for :user
end
