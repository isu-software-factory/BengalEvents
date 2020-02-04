require 'rails_helper'

RSpec.describe Teacher, type: :model do

  context "Validation tests" do
    before(:each) do
      @teacher = Teacher.first
      @role = Role.first
      @user = User.first
    end

    it "ensures chaperone_count presence" do
      teacher = @role.teachers.new(school_name: "Pocatello High School", user_id: @user.id).save
      expect(teacher).to eq(false)
    end

    it "ensures school name presence" do
      teacher = @role.teachers.new(chaperone_cont: 3, user_id: @user.id).save
      expect(teacher).to eq(false)
    end

    it "should be created successfully" do
      teacher = @role.teachers.new(school_name: "Pocatello High School", chaperone_cont: 3, user_id: @user.id).save
      expect(teacher).to eq(true)
    end
  end


  context "Association tests" do
    before(:each) do
      @role = Role.first
      @user = User.first
      @teacher = Teacher.first
    end

    it "is associated to a teacher role only" do
      expect(@teacher.role).to eq(@role)
    end

    it "is associated to a specific user" do
      expect(@teacher.user).to eq(@user)
    end
  end
end
