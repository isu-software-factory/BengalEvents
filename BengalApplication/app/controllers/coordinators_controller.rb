class CoordinatorsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]


  def new
    @coordinator = Coordinator.new
    @coordinator.build_user
    #authorize @coordinator
  end

  def create
    @coordinator = Coordinator.new(coordinator_params)
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

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def coordinator_params
    params.require(:coordinator).permit(:name, user_attributes: [:id, :email, :password, :password_confirmation])
  end
end
