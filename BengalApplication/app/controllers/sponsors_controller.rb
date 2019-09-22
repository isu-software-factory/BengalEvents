class SponsorsController < ApplicationController
  before_action :authenticate_user!, except: %i[new create]

  def new
    @sponsor = Sponsor.new
    @sponsor.build_user
  end

  def create
    @sponsor = Sponsor.new(sponsor_params)
    Supervisor.create(director: @sponsor)
    if @sponsor.save
      sign_in @sponsor.user
      redirect_to @sponsor
    else
      redirect_to new_sponsor_path
    end
  end

  def show
    @sponsor = Sponsor.find(params[:id])
    @occasions = Occasion.all
    @event = Event.find(params[:id])


    add_breadcrumb 'Home', @sponsor
  end

  def pdfshow
    @sponsor = Sponsor.find(params[:id])
    @occasions = Occasion.all
  end

  private

  def sponsor_params
    params.require(:sponsor).permit(:name, user_attributes: %i[id email password])
  end
end

