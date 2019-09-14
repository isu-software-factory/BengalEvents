require 'rails_helper'

RSpec.describe User, type: :model do
  fixtures :teachers, :users, :students, :sponsors, :coordinators

  context "validation tests" do
    it "ensures email presence" do
      @user = User.new(password: "password", meta_id: 1, meta_type: "Teacher").save
      expect(@user).to eq(false)
    end

    it "ensures password presence" do
      @user = User.new(email: "u@gmail.com", meta_id: 1, meta_type: "Teacher").save
      expect(@user).to eq(false)
    end

    it "should be create successfully" do
      @user = User.new(email: "u@gmail.com", password: "password", meta_id: 1, meta_type: "Teacher").save
      expect(@user).to eq(true)
    end
  end

  context "association tests" do
    before do
      @user = users(:student_1)
      @user1 = users(:teacher)
      @user2 = users(:sponsor)
      @user3 = users(:coordinator)
      @student = students(:student_1)
      @sponsor = sponsors(:sponsor_carlos)
      @teacher = teachers(:teacher_emily)
      @coordinator = coordinators(:coordinator_rebeca)
    end

    it "can have a student" do
      expect(@user.meta).to eq(@student)
    end

    it "can have a teacher" do
      expect(@user1.meta).to eq(@teacher)
    end

    it "can have a sponsor" do
      expect(@user2.meta).to eq(@sponsor)
    end

    it "can have a coordinator" do
      expect(@user3.meta).to eq(@coordinator)
    end
  end
end
