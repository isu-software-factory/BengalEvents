# == Schema Information
#
# Table name: coordinators
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#

class Coordinator < ApplicationRecord
  has_one :user, as: :meta, dependent: :destroy
  accepts_nested_attributes_for :user
  has_many :occasions

  validates :name, presence: true
end
