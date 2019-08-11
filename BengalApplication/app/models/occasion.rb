# == Schema Information
#
# Table name: occasions
#
#  id             :integer          not null, primary key
#  name           :string
#  start_date     :datetime
#  end_date       :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  coordinator_id :integer
#  description    :string
#

class Occasion < ApplicationRecord
  has_many :events, dependent: :destroy
  belongs_to :coordinator
  has_many :locations, dependent: :destroy
  validates :name, :start_date, :end_date, presence: true
  validates :description, presence: true
end
