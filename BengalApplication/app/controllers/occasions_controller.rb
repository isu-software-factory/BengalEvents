class OccasionsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: %i[index show edit]

  def index
    @occasions = Occasion.all
    add_breadcrumb "Home", current_user.meta
    add_breadcrumb "Occasion List", occasions_path
  end

  def new
    @occasion = current_user.meta.occasions.build
    authorize @occasion
    add_breadcrumb 'Home', current_user.meta
    add_breadcrumb 'New Occasion', new_occasion_path
  end

  def create
    occasion = current_user.meta.occasions.build(occasion_params)
    authorize occasion
    if occasion.save
      redirect_to new_occasion_location_path(occasion_id: occasion.id)
    else
      flash[:errors] = occasion.errors.full_messages
      redirect_back(fallback_location: new_occasion_path)
    end
  end

  def show
    @location = Location.all
    @occasion = Occasion.find(params[:id])
    authorize @occasion
    add_breadcrumb 'Home', current_user.meta
    add_breadcrumb @occasion.name, occasion_path(@occasion)
  end

  def edit
    @occasion = Occasion.find(params[:id])
    authorize @occasion
    add_breadcrumb "Home", current_user.meta
    add_breadcrumb @occasion.name,occasion_path(@occasion)
    add_breadcrumb "Edit", edit_occasion_path(@occasion)
  end

  def update
    @occasion = Occasion.find(params[:id])
    authorize @occasion
    if @occasion.update(occasion_params)
      redirect_to occasions_path, :notice => 'Successfully updated Occasion.'
    else
      flash[:errors] = @occasion.errors.full_messages
       render :edit
    end
  end

  def destroy
    occasion = Occasion.find(params[:id])
    authorize occasion
    if occasion.destroy
      redirect_to occasions_path, notice: 'Successfully Deleted Occasion.'
    else
      flash[:error] = 'We were unable to destroy the Occasion.'
    end
  end

  private

  def occasion_params
    params.require(:occasion).permit(:start_date, :description, :name)
  end
end

