class SponsorPdf < Prawn::Document
  def initialize(sponsor)
    super(top_margin: 70)
    @sponsor = sponsor
    name
  end

  def name
    table event_detail_all
  end

  def event_detail_all
    [["Name", "Description", "Make Ahead", "Location", "Capacity", "Start Time", "End Time"]] +
        @sponsor.supervisor.events.map do |event|
          event.event_details.map do |d|
            [event.name, event.description, event.isMakeAhead.to_s, event.location.name, d.capacity.to_s
            ]
          end
        end
  end
end
