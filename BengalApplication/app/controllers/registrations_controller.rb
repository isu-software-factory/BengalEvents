class RegistrationsController < ApplicationController
  before_action :authenticate_user!


  def register

    # get participant and event detail
    @participant = Participant.find(params[:part_id])
    event_detail = EventDetail.find(params[:id])
    # authorize participant as a registration policy
    authorize @participant, policy_class: RegistrationPolicy

    # add participant to event
    success = event_detail.register_participant(@participant)

    if success
      redirect_to @participant.member
    else
      event = Event.find(event_detail.event.id)
      occasion = Occasion.find(event.id)
      # capacity is full
      if event_detail.capacity_remaining == 0
        flash[:notice] = "Event capacity is full. Register for a different event."
        redirect_to controller: "registrations", action: "events", part_id: @participant.id, id: occasion.id
      else
        # already registered for event
        flash[:notice] = "You are already registered for this event"
        redirect_to controller: "registrations", action: "events", part_id: @participant.id, id: occasion.id
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
      add_breadcrumb "Registration", controller: "registrations", action: "events", part_id: @participant_id, id: @occasion.id
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

  def drop
    # drop participants from events
    @participant = Participant.find(params[:part_id])
    @event_detail = EventDetail.find(params[:id])

    authorize @participant, policy_class: RegistrationPolicy
    @event_detail.participants.delete(@participant)
    redirect_to @participant.member
  end


end
