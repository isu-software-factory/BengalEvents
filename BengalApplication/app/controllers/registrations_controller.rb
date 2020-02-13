class RegistrationsController < ApplicationController
  #before_action :authenticate_user!, except: :registers


  def register
    # get participant and event detail
    # @participant = Participant.find(params[:part_id])
    @user = User.find(params[:user_id])
    # @event_detail = EventDetail.find(params[:id])
    @session = Session.find(params[:id])

    @activity = @session.activity
    # @event = @event_detail.event
    #
    # authorize participant as a registration policy
    # authorize @participant, policy_class: RegistrationPolicy

    # add participant to event
    # success = @event_detail.register_participant(@participant)
    #
    success = @session.register_participant(@user)

    if success
      #sadfasd
      if @session.ismakeahead
        redirect_to @participant.member, :notice => "You will be sent and email prior to the event."
      else
        redirect_to @participant.member, :notice => "Successfully registered for #{@event_detail.event.name}"
        #asdfa
      end
    else
      #@event = Event.find(@event_detail.event.id)
      #
      @activity = Activity.find(@session.activity.id)

      #@occasion = Occasion.find(@event.occasion.id)
      #
      @event = Event.find(@activity.event.id)
      # capacity is full
      if @session.capacity_remaining == 0
        flash[:alert] = "Event capacity is full. Register for a different event."
        #redirect_to controller: "registrations", action: "events", part_id: @participant.id, id: @occasion.id
        redirect_to controller: "registrations", action: "events", user_id: @user.id, id: @event.id

        return
      else
        # already registered for event
        flash[:alert] = "You are already registered for this event"
        redirect_to "/teachers/1"
        return
      end
    end
  end

  def events
    @participant_id = params[:part_id]
    @participant = User.find(params[:id])
    @occasion = Event.first
    @events = @occasion.activities
    # authorize participant as a registration policy
    authorize @participant, policy_class: RegistrationPolicy
    if @participant.member_type == "Team"
      add_breadcrumb "Home", current_user.meta
      add_breadcrumb "Team", @participant.member
      add_breadcrumb "Occasions", controller: "registrations", action: "index", part_id: @participant_id
      add_breadcrumb "Registration", ""
    else
      add_breadcrumb "Home", current_user.meta
      add_breadcrumb "Occasions", controller: "registrations", action: "index", part_id: @participant_id
      add_breadcrumb "Registration", controller: "registrations", action: "activities", part_id: @participant_id, id: @occasion.id
    end


  end

  def index
    @participant_id = params[:part_id]
    @participant = Participant.find(@participant_id)
    @occasions = Occasion.all
    # authorize participant as a registration policy
    authorize @participant, policy_class: RegistrationPolicy
    if @participant.member_type == "Team"
      add_breadcrumb "Home", current_user.meta
      add_breadcrumb "Team", @participant.member
      add_breadcrumb "Occasions", controller: "registrations", action: "index", part_id: @participant_id
    else
      add_breadcrumb "Home", current_user.meta
      add_breadcrumb "Occasions", controller: "registrations", action: "index", part_id: @participant_id
    end

  end

  def add_to_waitlist
    # adds the participant to the activities waitlist
    @participant = Participant.find(params[:part_id])
    @event_detail = EventDetail.find(params[:id])

    @event_detail.waitlist.participants << @participant
    redirect_to @participant.member, :notice => "You have been added to the WaitList"
  end

  def drop
    #authorize @participant, policy_class: RegistrationPolicy
    drop_user
    # when participant is drop check waitlist
    #@event_detail.wait_list_check
    redirect_to root_path
  end

  def drop_activity
    success = drop_user
    if success
      render json: {drop: {success: true}}
    else
      render json: {drop: {success: false}}
    end
  end

  def registers
    event = Session.find(params[:id].to_i)
    participant = current_user

    # add participant to event
    success = event.register_participant(participant)

    if success
      render json: {data: {registered: true, user: participant.id}}
    else
      render json: {data: {registered: false}}
    end

  end

  private

  def drop_user
    # drop participants from activities
    @session = Session.find(params[:session_id])
    @user = User.find(params[:user_id])

    @session.users.delete(@user)

    if !@session.users.include?(@user)
      true
    else
      false
    end
  end
end