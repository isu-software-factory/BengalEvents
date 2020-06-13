module EventsHelper

  def show?(event)
    @show = true
    if event.visible_constraint != nil
      if DateTime.now >= event.visible_constraint
        @show = false
      end
    else
      @show = event.visible
    end
    @show
  end
end
