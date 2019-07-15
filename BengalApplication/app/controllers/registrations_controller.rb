class RegistrationsController < ApplicationController

  def register
    event = EventDetail.find(params[:id])
    @student = Student.find(current_user.meta.id)
    event.students << @student
    redirect_to @student
  end

  def events
    occasion = Occasion.find(params[:id])
    @events = occasion.events
  end

  def index
    @occasions = Occasion.all
  end

end
