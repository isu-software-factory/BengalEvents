class SponsorsController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]

  def index
      @sponsor = Sponsor.all
    end

    def new
      @sponsor = Sponsor.new
      @sponsor.build_user
    end

    def create
      @sponsor = Sponsor.new(sponsor_params)
      if @sponsor.save
        redirect_to root_path
      else
        render :new
      end
    end

    def show
      @sponsor = Sponsor.find(params[:id])
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def sponsor_params
      params.require(:sponsor).permit(:name, user_attributes: [:id, :email, :password])
    end
  end

