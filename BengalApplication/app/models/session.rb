class Session < ApplicationRecord
  belongs_to :activity
  has_many :rooms
  has_many :registrations
  has_many :team_registration
  has_many :teams, through: :team_registration
  has_many :users, through: :registrations
  validates :start_time, :end_time, presence: true
  validates_uniqueness_of :start_time, :end_time
  validates :capacity, presence: true

  #has_one :waitlist

  #  validate :end_must_be_after_start
  #
  #  def end_must_be_after_start
  #    if self.start_time != nil && self.end_time != nil
  #      if self.start_time >= self.end_time
  #        errors.add(:end_time, 'must be after start time')
  #      end
  #    end
  #  end

  # register participant to session
  # Makes sure that participant isn't already registered and that the capacity is zero
  def register_participant(participant)
    success = false
    unless self.capacity_remaining == 0
      if self.activity.iscompetetion
        success = self.register_team(participant)
      else
        success = self.register_user(participant)
      end
    end
    success
  end

  def register_user(user)
    unless self.users.include?(user)
      self.users << user
      return true
    end
    false
  end

  def register_team(team)
    unless self.teams.include?(team)
      self.teams << team
      return true
    end
    false
  end


  # Capacity remaining for event detail
  def capacity_remaining
    # Go through participants to decrease capacity
    @remaining = self.capacity
    if self.activity.iscompetetion
      self.teams.each do |t|
        @remaining -= 1
      end
    else
      self.users.each do |p|
        @remaining -= 1
      end
    end
    @remaining
  end


  ## sends an email to a participant and automatically registers student for event
  #  def wait_list_check
  #    # checks to see if the even has a spot open and if there is anyone on the wait list
  #    if self.capacity_remaining > 0
  #      if self.waitlist.participants.count > 0
  #        # get first person on wait_list
  #        @participant = self.waitlist.participants[0]
  #
  #        # register participant and send email
  #        self.register_participant(@participant)
  #        UserMailer.notice(@participant, self).deliver_now
  #
  #        # remove participant from waitlist
  #        self.waitlist.participants.delete(@participant)
  #      end
  #    end
  #  end


  # make ahead email will be sent to all registered participant
  def send_make_ahead(participant)
    if self.event.isMakeAhead
      # send email one week prior to event
      @week = self.date_started - 7
      @day = self.date_started - 1

      if @week > Date.today
        UserMailer.event_notice(participant, self.event).deliver_later(wait_until: @week)
      end

      # send an email 1 day before event
      if @day > Date.today
        UserMailer.event_notice(participant, self.event).deliver_later(wait_until: @day)
      end
    end
  end

end
