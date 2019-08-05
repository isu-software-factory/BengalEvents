class RegistrationsController < ApplicationController
  before_action :authenticate_user!
  def register
    # get participant and event detail
    @participant = Participant.find(params[:part_id])
    event = EventDetail.find(params[:id])
    # authorize participant as a registration policy
    authorize @participant, policy_class: RegistrationPolicy

    # add participant to event
    event.participants << @participant
    redirect_to @participant.member
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
