class SponsorsController < ApplicationController
  before_action :authenticate_user!, except: :new

  def index
      @sponsor = Sponsor.all
    end

    def new
      @sponsor = Sponsor.new
    end

    def create
      @sponsor = Sponsor.new(sponsor_params)
      if @sponsor.save
        redirect_to @sponsor
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
      params.require(:sponsor).permit(:name,user_attributes: [:id, :email, :password])
    end
  end

