require 'rails_helper'

RSpec.describe Room, type: :model do
  context "Validation Tests" do
    before(:each) do
      @num = "123"
      @name = "Caffe"
      @location = Location.first
      @session = Session.first
    end

    it "ensures room number" do
      room = @location.rooms.new(room_name: @name).save
      expect(room).to eq(false)
    end

    it "room name can be left blank and room will be created successfully" do
      room = @location.rooms.new(room_number: @num, session_id: @session.id).save
      expect(room).to eq(true)
    end

    it "room name can be filled and room will be created successfully" do
      room = @location.rooms.new(room_number: @num, room_name: @name, session_id: @session.id).save
      expect(room).to eq(true)
    end
  end


end
