require 'rails_helper'

RSpec.feature "Students", type: :feature do
  fixtures :teachers, :students, :users, :participants

  context "create student" do
    before(:each) do
      @teacher = Teacher.create(name: "Kelly", school: "Pocatello", student_count: 1, chaperone_count: 1, user_attributes:{email: "teach@gmail.com", password: "password"}, participant_attributes:{})
      login_as(@teacher.user)
      visit new_student_path
    end

    scenario "should be successful" do
      # add new student
      within("form") do
        fill_in "name_1", with: "student"
        fill_in "email_1", with: "s@gmail.com"
      end
        click_button "Submit Changes"
        expect(@teacher.students.count).to eq(1)
    end

    scenario "should fail" do
      within("form") do
        fill_in "name_1", with: ""
        fill_in "email_1", with: "s@gmail.com"
      end
      click_button "Submit Changes"
      expect(@teacher.students.count).to eq(0)
      expect(page).to have_content("Name can't be blank")
    end
  end


  context "update student through teacher" do
    before(:each) do
      @teacher = teachers(:teacher_emily)
      login_as(@teacher.user)
      visit new_student_path
    end

    scenario "should be successful" do
      # edit student 2
      within("form") do
        fill_in  "name_2", with: "Billy Smith"
        fill_in "email_2", with: "bill@gmail.com"
      end

      click_button "Submit Changes"
      expect(page).to have_content("Billy Smith")
      expect(page).to have_content("bill@gmail.com")
    end

    scenario "should fail" do
      # edit student 2
      within("form") do
        fill_in "email_2", with: ""
      end

      click_button "Submit Changes"
      expect(page).to have_content("Email can't be blank")
    end
  end


  context "update student through student" do
    before(:each) do
      @student = students(:student_1)
      login_as(@student.user)
      visit edit_user_registration_path(@student.user)
    end

    scenario "should be successful" do

    end
  end


   context "destroy student through teacher" do
     before(:each) do
       @teacher = teachers(:teacher_emily)
       login_as(@teacher.user)
       visit new_student_path
     end

     scenario "should be successful" do
       # click minus button
       find(".glyphicon-minus", match: :first).click()

       expect(page).not_to have_content("Robert")
     end
   end

end


