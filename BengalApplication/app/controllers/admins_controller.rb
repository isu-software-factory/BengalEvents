class AdminsController < ApplicationController
  before_action :authenticate_user!
  def show
    @admin = Admin.find(params[:id])
    @occasions = Occasion.all
    @coordinators = Coordinator.all
    @teachers = Teacher.all
    @students = Student.all
    @sponsors = Sponsor.all
    authorize @admin
    add_breadcrumb 'Home', @admin
  end
end
