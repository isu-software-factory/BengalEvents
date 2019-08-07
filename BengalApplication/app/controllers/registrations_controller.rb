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
      # already registered for event
      event = Event.find(event_detail.event.id)
      occasion = Occasion.find(event.id)
      flash[:notice] = "You are already registered for this event"
      redirect_to controller: "registrations", action: "events", part_id: @participant.id, id: occasion.id
    end
  end

  def events
    @participant_id = params[:part_id]
    @participant = Participant.find(@participant_id)
    occasion = Occasion.find(params[:id])
    @events = occasion.events
    # authorize participant as a registration policy
    authorize @participant, policy_class: RegistrationPolicy
  end

  def index
    @participant_id = params[:part_id]
    @participant = Participant.find(@participant_id)
    @occasions = Occasion.all
    # authorize participant as a registration policy
    authorize @participant, policy_class: RegistrationPolicy
  end

end
