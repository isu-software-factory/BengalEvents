class CoordinatorsController < ApplicationController
  before_action :authenticate_user!, except: %i[new create]

  def new
    @coordinator = Coordinator.new
    @coordinator.build_user
  end

  def create
    @coordinator = Coordinator.new(coordinator_params)
    Supervisor.create(director: @coordinator)
    if @coordinator.save
      sign_in @coordinator.user
      redirect_to @coordinator
    else
      render :new
    end
  end

  def show
    @coordinator = Coordinator.find(params[:id])
    @occasions = Occasion.all
    authorize @coordinator
    add_breadcrumb 'Home', @coordinator
  end

  private

  def coordinator_params
    params.require(:coordinator).permit(:name, user_attributes: %i[id email password password_confirmation])
  end
end
