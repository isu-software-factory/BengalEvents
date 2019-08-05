class OccasionsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:index, :show, :edit]


  def index
    @occasions = Occasion.all
  end

  def new
    @occasion = current_user.meta.occasions.build
    # @location = @occasion.locations.build
    # @location.time_slots.build
    authorize @occasion
  end


  def create
    occasion = current_user.meta.occasions.build(occasion_params)
    authorize occasion
    if occasion.save
      redirect_to occasions_path
    else
      flash[:errors] = occasion.errors.full_messages
      redirect_back(fallback_location: new_occasion_path)
    end
  end

  def show
    @occasion = Occasion.find(params[:id])
    authorize @occasion
  end

  def edit
    @occasion = Occasion.find(params[:id])
    authorize @occasion
  end

  def update
    occasion = Occasion.find(params[:id])
    authorize occasion
    if occasion.update(occasion_params)
      redirect_to occasions_path
    else
      flash[:errors] = occasion.errors.full_messages
      redirect_back(fallback_location: edit_occasion_path(occasion.id))
    end
  end

  def destroy
    occasion = Occasion.find(params[:id])
    authorize occasion
    occasion.destroy
    redirect_to occasions_path
  end

  private

  def occasion_params
    params.require(:occasion).permit(:start_date, :end_date, :description, :name,
                                     locations_attributes: [:id, :name, time_slots_attributes: [:interval, :start_time, :end_time]])
  end

end

