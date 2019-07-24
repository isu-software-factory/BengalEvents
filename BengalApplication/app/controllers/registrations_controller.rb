class RegistrationsController < ApplicationController
  before_action :authenticate_user!
  def register
    # register participant
    # get participant
    @participant = Participant.find(params[:part_id])
    event = EventDetail.find(params[:id])
    event.participants << @participant
    redirect_to @participant.member
  end

  def events
    @participant = params[:part_id]
    occasion = Occasion.find(params[:id])
    @events = occasion.events
  end

  def index
    @participant = params[:part_id]
    @occasions = Occasion.all
  end

end
