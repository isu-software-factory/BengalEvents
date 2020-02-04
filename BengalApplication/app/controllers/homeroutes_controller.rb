class HomeroutesController < ApplicationController
  def home
    # user signed in then redirect them to their page
    if user_signed_in?
      redirect_to :controller => "homeroutes", :action => "user"
    end
    # if user isn't signed in then show events for current occasion
    unless Event.first.nil?
      @event = Event.first
      @activities = @event.activities
    end
  end

  def users

  end
end
