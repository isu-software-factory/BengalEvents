class Event < ApplicationRecord
  has_many :activities, dependent: :destroy
  #has_many :locations, dependent: :destroy
  validates :name, :start_date, presence: true
  validates :description, presence: true
  # validate :end_must_be_after_start

  #   def end_must_be_after_start
  #     # make sure that neither dates are nil before running method
  #     if self.start_date != nil && self.end_date != nil
  #       if self.start_date > self.end_date
  #         errors.add(:end_time, 'must be after start time')
  #       end
  #     end
  #   end
end
