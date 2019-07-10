class HomeroutesController < ApplicationController

  def routes
    if user_signed_in?
      redirect_to occasion_event_path
    end
  end
end
