class Session < ApplicationRecord
  belongs_to :activity
  belongs_to :room
  has_many :registrations
  has_many :team_registration
  has_many :teams, through: :team_registration, :dependent => :delete_all
  has_many :users, through: :registrations, :dependent => :delete_all
  # validates :start_time, :end_time, presence: true
  # validates_uniqueness_of :start_time, :end_time
  validates :capacity, presence: true
  has_one :waitlist

  # validates :start_date, :end_date, overlap: true
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
    success = [false]
    unless self.capacity_remaining == 0
      if self.activity.iscompetetion
        success = self.register_team(participant)
      else
        success = self.register_user(participant)
      end
    else
      success = [false, "Activity capacity is full. Register for a different Activity."]
    end
    success
  end

  def register_user(user)
    success = [false]
    unless self.users.include?(user)
      self.users << user
      success = [true, ""]
    else
      success = [false, "You have already registered for this event"]
    end
    success
  end

  def register_team(team)
    success = [false]
    if self.teams.include?(team)
      self.teams << team
      success = [false, "Your team is already registered for this event"]
    elsif (self.activity.max_team_size < team.users.count || self.activity.max_team_size < team.users.count)
      success = [false, "Your team does not meet the team size restriction"]
    else
      self.teams << team
      success = [true, ""]
    end
    success
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
  def wait_list_check
    # checks to see if the session has a spot open and if there is, register the first person on the waitlist
    if self.capacity_remaining > 0
      if self.waitlist.users.count > 0
        # get first person on wait_list
        @participant = self.waitlist.users[0]
        # register participant and send email
        self.register_participant(@participant)

        # remove participant from waitlist
        self.waitlist.users.delete(@participant)
      end
    end
  end


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
