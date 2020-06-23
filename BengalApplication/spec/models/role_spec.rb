require 'rails_helper'

RSpec.describe Role, type: :model do

  context "association tests" do
    before(:each) do
      @teacher = Role.first
      @t_user = User.first
      @student = Role.find(2)
      @s_user = User.find(2)
      @sponsor = Role.find(3)
      @sp_user = User.find(7)
      @admin = Role.find(4)
      @a_user = User.find(8)
      @coordinator = Role.find(5)
      @c_user = User.find(9)
      @participant = Role.find(6)
      @organizer = Role.find(7)

    end

    it "teacher role has a user" do
      expect(@teacher.users.first).to eq(@t_user)
    end

    it "student role has a user" do
      expect(@student.users.first).to eq(@s_user)
    end

    it "sponsor role has a user" do
      expect(@sponsor.users.first).to eq(@sp_user)
    end

    it "admin role has a user" do
      expect(@admin.users.first).to eq(@a_user)
    end

    it "coordinator role has a user" do
      expect(@coordinator.users.first).to eq(@c_user)
    end

    it "participant role has a user" do
      expect(@participant.users.first).to eq(@t_user)
    end

    it "organizer role has a user" do
      expect(@organizer.users.first).to eq(@sp_user)
    end
  end
end
