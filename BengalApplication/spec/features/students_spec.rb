require 'rails_helper'

RSpec.feature "Students", type: :feature do
  context "create student" do
    before(:each) do
      teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "te@gmail.com", password: "password"}, participant_attributes: {})
      login_as(teacher.user, :scope => :user)
      visit new_student_path
    end
    scenario "should be successful" do
      within("form") do
        fill_in "student[name]", with: "student"
        fill_in "student[user_attributes][email]", with: "s@gmail.com"
      end
        click_button "Add Student"
        expect(page).to have_content("Add students here")
    end

    scenario "should fail" do
      within("form") do
        fill_in "student[name]", with: ""
        fill_in "student[user_attributes][email]", with: "s@gmail.com"
      end
      click_button "Add Student"
      expect(page).to have_content("Name can't be blank")
    end
  end

  context "update student" do
    before(:each) do
      teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "te@gmail.com", password: "password"})
      student = teacher.students.build(name: "Bill", user_attributes: {email: "student@gmail.com", password: "password"})
      student.save
      login_as(student.user, :scope => :user)
      visit edit_student_path(student.id)
    end
    scenario "should be successful" do
      within("form") do
        fill_in  "user[password]", with: "newpassword"
      end
      click_button "update"
      expect(page).to have_content("Student main page")
    end
    scenario "should fail" do
      within("form") do
        fill_in "user[password]", with: ""
        expect(page).to have_content("Password can't be blank")
      end
    end
  end

  # context "destroy student" do
  #   scenario "should be successful" do
  #     teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "te@gmail.com", password: "password"})
  #     student = teacher.students.build(name: "Bill", user_attributes: {email: "student@gmail.com", password: "password"})
  #     student.save
  #     coordinator = Coordinator.create(name: "coordinator", user_attributes: {email: "pasl@gmail.com", password: "password"})
  #     login_as(coordinator.user, :scope => :user)
  #     visit student_path
  #     #click_link "delete"
  #     expect{click_link 'Delete'}.to change(Student, :count).by(-1)
  #     expect(page).to have_content("Student was successfully deleted")
  #
  #   end
  # end

end


