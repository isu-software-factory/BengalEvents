class OccasionsController < ApplicationController
  def index
    @occasions = Occasion.all
  end

  def new
    @occasion = Occasion.new
  end

  def create
    occasion = Occasion.new(occasion_params)
    if occasion.save
      redirect_to occasions_path
    else
      flash[:errors] = occasion.errors.full_messages
      redirect_back(fallback_location: new_occasion_path)
    end
  end

  def show
    @occasion = Occasion.find(params[:id])
  end

  def edit
    @occasion = Occasion.find(params[:id])
  end

  def update
    occasion = Occasion.find(params[:id])
    if occasion.update(occasion_params)
      redirect_to occasions_path
    else
      flash[:errors] = occasion.errors.full_messages
      redirect_back(fallback_location: edit_occasion_path(occasion.id))
    end
  end

  def destroy
    occasion = Occasion.find(params[:id])
    occasion.destroy
    redirect_to occasions_path
  end

  private

  def occasion_params
    params.require(:occasion).permit(:name, :end_date, :start_date)
  end
end

