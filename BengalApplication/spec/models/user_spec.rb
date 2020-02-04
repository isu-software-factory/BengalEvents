require 'rails_helper'

RSpec.describe User, type: :model do

  context "validation tests" do
    it "ensures email presence" do
      @user = User.new(password: "password", first_name: "Bill", last_name: "Smith", user_name: "Smith232" ).save
      expect(@user).to eq(false)
    end

    it "ensures password presence" do
      @user = User.new(email: "em@gmail.com", first_name: "Bill", last_name: "Smith", user_name: "Smith232" ).save
      expect(@user).to eq(false)
    end

    it "ensures first name presence" do
      @user = User.new(password: "password", last_name: "Smith", user_name: "Smith232", email: "em@gmail.com" ).save
      expect(@user).to eq(false)
    end

    it "ensures last name presence" do
      @user = User.new(password: "password", first_name: "Bill", user_name: "Smith232", email: "em@gmail.com" ).save
      expect(@user).to eq(false)
    end

    it "ensures user name presence" do
      @user = User.new(password: "password", first_name: "Bill", last_name: "Smith", email: "em@gmail.com" ).save
      expect(@user).to eq(false)
    end

    it "should be create successfully" do
      @user = User.new(password: "password", first_name: "Bill", last_name: "Smith", user_name: "Smith232", email: "em@gmail.com" ).save
      expect(@user).to eq(true)
    end
  end

  context "association tests" do
    before do
      @user = User.find(2)
      @user2 = User.find(1)
      @user3 = User.find(7)
      @user4 = User.find(9)
      @user5 = User.find(8)
      @teacher = Role.first
      @student = Role.find(2)
      @sponsor = Role.find(3)
      @admin = Role.find(4)
      @coordinator = Role.find(5)
      @participant = Role.find(6)
      @organizer = Role.find(7)

    end

    it "can have a student" do
      expect(@user.roles.first).to eq(@student)
    end

    it "can have a teacher" do
      expect(@user1.roles.first).to eq(@teacher)
    end

    it "can have a sponsor" do
      expect(@user2.roles).to eq(@sponsor)
    end

    it "can have a coordinator" do
      expect(@user3.roles).to eq(@coordinator)
    end
  end
end
