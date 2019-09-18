class TeachersController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]


  # shows teacher new page
  def new
    @teacher = Teacher.new
    @teacher.build_user
  end

  # creates a new teacher
  def create
    # create teacher and participant
    @teacher = Teacher.new(teacher_params)
    Participant.create(member: @teacher)

    if @teacher.save
      # sign in teacher and redirect to students new page
      sign_in @teacher.user
      redirect_to "/students/new"
    else
      render :new
    end
  end

  # shows teacher main page
  def show
    @teacher = Teacher.find(params[:id])
    authorize @teacher
    @students = organize_students(@teacher.students)
    add_breadcrumb "Home", @teacher
  end

  # shows the print page for class registration
  def print_class_registrations
    @teacher = Teacher.find(params[:id])
    @students = @teacher.students

  end

  # shows class registrations page
  def class_registrations

    # display every student registrations
    @teacher = Teacher.find(params[:id])
    @students = @teacher.students

    # add breadcrumbs
    add_breadcrumb "Home", current_user.meta
    add_breadcrumb "Class Registrations", controller: "teachers", action: "class_registrations", id: @teacher.id
  end


  # def edit
  #   @teacher = Teacher.find(params[:id])
  #   authorize @teacher
  #
  #   # add breadcrumbs
  #   add_breadcrumb "Account Settings", edit_teacher_path(@teacher)
  # end

  # # shows edit page
  # def update
  #   @teacher = Teacher.find(params[:id])
  #   authorize @teacher
  #
  #   # update teacher and redirect to teacher page
  #   if @teacher.update_attributes(teacher_params)
  #     redirect_to @teacher, :notice => "Successfully updated"
  #   else
  #     render 'edit'
  #   end
  # end

  private

  def teacher_params
    params.require(:teacher).permit(:school, :name, :student_count, :chaperone_count, user_attributes: [:id, :email, :password, :password_confirmation])
  end

  # sort students by name
  def organize_students(students_list)
    students_list.sort_by{|s| s.name}
  end
end
