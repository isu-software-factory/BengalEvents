class OccasionPdf < Prawn::Document
  def initialize(occasion)
    super(top_margin: 70)
    @occasion = occasion
    name
  end

  def name
    text "Occasion name  \##{@occasion.name}"
    text "Start Date  \##{@occasion.start_date}"
    text "End Date  \##{@occasion.end_date}"
  end


end
