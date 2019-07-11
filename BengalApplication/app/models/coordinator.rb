class Coordinator < ApplicationRecord
  has_one :user, as: :Identifiable, dependent: :destroy
  accepts_nested_attributes_for :user
  has_many :occasions
end