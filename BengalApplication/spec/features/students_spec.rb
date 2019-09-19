require 'rails_helper'

RSpec.feature "Students", type: :feature do
  context "create student" do
    before(:each) do
      @teacher = Teacher.create(name: "Kelly", school: "Pocatello", student_count: 1, chaperone_count: 1, user_attributes:{email: "teach@gmail.com", password: "password"}, participant_attributes:{})
      login_as(@teacher.user)
      visit new_student_path
    end

    scenario "should be successful" do
      within("form") do
        fill_in "name1", with: "student"
        fill_in "email1", with: "s@gmail.com"
      end
        click_button "Add Student"
        expect(@teacher.students.count).to eq(1)
    end

    scenario "should fail" do
      within("form") do
        fill_in "name1", with: ""
        fill_in "email1", with: "s@gmail.com"
      end
      click_button "Add Student"
      expect(@teacher.students.count).to eq(0)
      expect(page).to have_content("Name can't be blank")
    end
  end


  context "update student" do
    before(:each) do
      teacher = Teacher.create(chaperone_count: 3, student_count: 23, school: "valley", name: "teacher", user_attributes: {email: "te@gmail.com", password: "password"})
      @student = teacher.students.build(name: "Bill", user_attributes: {email: "student@gmail.com", password: "password"}, participant_attributes: {})
      @student.save
      login_as(@student.user)
      visit edit_user_registration_path(@student.user)
    end

    scenario "should be successful" do
      within("form#edit_user") do
        fill_in  "user_password", with: "newpassword"
        fill_in "user_password_confirmation", with: "newpassword"
        fill_in "user_current_password", with: "password"
      end
      click_button "Update"
      expect(page).to have_content("Your account has been updated successfully.")
    end

    scenario "should fail" do
      within("form#edit_user") do
        fill_in "user_email", with: ""
      end
      click_button "Update"
      expect(page).to have_content("Email can't be blank")
    end
  end

  # Not yet implemented
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
  #   end
  # end

end


