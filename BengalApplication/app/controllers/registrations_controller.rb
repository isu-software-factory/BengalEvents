class RegistrationsController < ApplicationController
  before_action :authenticate_user!, except: :registers


  def register
    # get participant and event detail
    @participant = Participant.find(params[:part_id])
    @event_detail = EventDetail.find(params[:id])
    @event = @event_detail.event
    # authorize participant as a registration policy
    authorize @participant, policy_class: RegistrationPolicy

    # add participant to event
    success = @event_detail.register_participant(@participant)

    if success
      #sadfasd
      if @event.isMakeAhead
        redirect_to @participant.member, :notice => "You will be sent and email prior to the event."
      else
        redirect_to @participant.member, :notice => "Successfully registered for #{@event_detail.event.name}"
        #asdfa
      end
    else
      @event = Event.find(@event_detail.event.id)
      @occasion = Occasion.find(@event.occasion.id)
      # capacity is full
      if @event_detail.capacity_remaining == 0
        flash[:alert] = "Event capacity is full. Register for a different event."
        redirect_to controller: "registrations", action: "events", part_id: @participant.id, id: @occasion.id
        return
      else
        # already registered for event
        flash[:alert] = "You are already registered for this event"
        redirect_to controller: "registrations", action: "events", part_id: @participant.id, id: @occasion.id
        return
      end
    end
  end

  def events
    @participant_id = params[:part_id]
    @participant = Participant.find(@participant_id)
    @occasion = Occasion.find(params[:id])
    @events = @occasion.events
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
    # drop participants from activities
    @participant = Participant.find(params[:part_id])
    @event_detail = EventDetail.find(params[:id])

    authorize @participant, policy_class: RegistrationPolicy
    @event_detail.participants.delete(@participant)

    # when participant is drop check waitlist
    @event_detail.wait_list_check
    redirect_to @participant.member
  end

  def registers
    event = EventDetail.find(params[:id].to_i)
    participant = current_user.meta.participant

    # add participant to event
    success = event.register_participant(participant)

    if success
      render json: {data: {registered: true}}
    else
      render json: {data: {registered: false}}
    end

  end

end
