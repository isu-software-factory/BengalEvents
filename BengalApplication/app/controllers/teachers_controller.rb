class TeachersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]


  def new
    @teacher = Teacher.new
    @teacher.build_user
  end

  def create
    @teacher = Teacher.new(teacher_params)
    Participant.create(member: @teacher)
    if @teacher.save
      sign_in @teacher.user
      redirect_to "/students/new"
    else
      render :new
    end
  end

  def show
    @teacher = Teacher.find(params[:id])
    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     doc = Prawn::Document.generate("test.pdf") do
    #       text "Hello World"
    #     end
    #   end
    # end
    @students = organize_students(@teacher.students)
    add_breadcrumb "Home", @teacher
  end

  def edit
    @teacher = Teacher.find(params[:id])
    authorize @teacher
    add_breadcrumb "Account Settings", edit_teacher_path(@teacher)
  end

  def update
    @teacher = Teacher.find(params[:id])
    authorize @teacher
    if @teacher.update_attributes(teacher_params)
      redirect_to @teacher, :notice => "Successfully updated"
    else
      render 'edit'
    end
  end

  private

  def teacher_params
    params.require(:teacher).permit(:school, :name, :student_count, :chaperone_count, user_attributes: [:id, :email, :password, :password_confirmation])
  end

  def organize_students(students_list)
    students_list.sort_by{|s| s.name}
  end
end
