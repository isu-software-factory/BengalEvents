class OccasionsController < ApplicationController
  def index
    @occasions = Occasion.all
  end

  def create
    occasion = Occasion.new(occasion_params)
    if occasion.save
      redirect_to "/occasions"
    else
      flash[:errors] = occasion.errors.full_messages
      redirect_to "/occasions/new"
    end
  end

  def show
    @occasion = Occasion.find(params[:id])
  end

  def edit
    @occasion = Occasion.find(params[:id])
  end

  private
  def occasion_params
    params.require(:occasion).permit(:name, :end_date, :start_date)
  end
end

