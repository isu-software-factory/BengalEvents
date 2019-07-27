class CoordinatorsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]


  def new
    @coordinator = Coordinator.new
    @coordinator.build_user
  end

  def create
    @coordinator = Coordinator.new(coordinator_params)
    if @coordinator.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @coordinator = Coordinator.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def coordinator_params
    params.require(:coordinator).permit(:name, user_attributes: [:id, :email, :password])
  end
end
