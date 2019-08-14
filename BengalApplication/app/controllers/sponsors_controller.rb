class SponsorsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]

  def new
    @sponsor = Sponsor.new
    @sponsor.build_user
    authorize @sponsor
  end

  def create
    @sponsor = Sponsor.new(sponsor_params)
    if @sponsor.save
      sign_in @sponsor.user
      redirect_to @sponsor
    else
      render :new
    end
  end

  def show
    @sponsor = Sponsor.find(params[:id])
    @occasions = Occasion.all
  end

  private

  def sponsor_params
    params.require(:sponsor).permit(:name, user_attributes: [:id, :email, :password])
  end
end

