class SponsorsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]

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
    respond_to do |format|
      format.html
      format.pdf do
        pdf = SponsorPdf.new(@sponsor)
        send_data pdf.render, filename: "sponsor.pdf",
                  type: "application/pdf", disposition: "inline"
      end
    end
    add_breadcrumb "Home", @sponsor
  end

  private

  def sponsor_params
    params.require(:sponsor).permit(:name, user_attributes: [:id, :email, :password])
  end
end

