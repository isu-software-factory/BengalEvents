require 'rails_helper'
include Warden::Test::Helpers
RSpec.feature "Activities", type: :feature do

  context "create new activity" do
    before(:each) do
      @sponsor = User.find(7)
      # log in
      login_as(@sponsor)
      visit new_activity_path(event_id: 1)
    end

    it "should be successful with all inputs entered" do
      within('form') do
        fill_in "name_New_1", with: "Robots in the gym"
        fill_in "description_1", with: "All about robots"
        select("SUB (921 S 8th Ave, Pocatello, ID 83209)", from: "location_select_1")
        fill_in "start_time_New_1", with: "9:30"
        fill_in "end_time_1", with: "10:30"
        select("102 (Cafe)", from: "room_select_1")
        fill_in "capacity_1", with: "3"
      end

      click_button 'Confirm'
      expect(page).to have_content("Successfully Created Activity")
    end

    it "should be successful with multiple sessions" do
      within('form') do
        fill_in "name_New_1", with: "Robots in the gym"
        fill_in "description_1", with: "All about robots"
        select("SUB (921 S 8th Ave, Pocatello, ID 83209)", from: "location_select_1")
        fill_in "start_time_New_1", with: "9:30"
        fill_in "end_time_1", with: "10:30"
        select("102 (Cafe)", from: "room_select_1")
        fill_in "capacity_1", with: "3"
      end

      first(".new-session").click

      within("form") do
        fill_in "start_time_2", with: "11:30"
        fill_in "end_time_2", with: "12:30"
        select("102 (Cafe)", from: "room_select_2")
        fill_in "capacity_2", with: "3"
      end

      click_button 'Confirm'
      expect(page).to have_content("Successfully Created Activity")
    end

    it "should be successful when using same room checkbox" do
      within('form') do
        fill_in "name_New_1", with: "Robots in the gym"
        fill_in "description_1", with: "All about robots"
        select("SUB (921 S 8th Ave, Pocatello, ID 83209)", from: "location_select_1")
        fill_in "start_time_New_1", with: "9:30"
        fill_in "end_time_1", with: "10:30"
        fill_in "capacity_1", with: "3"
      end

      first(".new-session").click

      # second session
      within("form") do
        fill_in "start_time_2", with: "11:30"
        fill_in "end_time_2", with: "12:30"
        fill_in "capacity_2", with: "3"
      end

      first(".new-session").click

      # third session
      within("form") do
        fill_in "start_time_3", with: "1:30"
        fill_in "end_time_3", with: "2:30"
        fill_in "capacity_3", with: "3"
      end

      within("form") do
        select("203 (Ballroom)", from: "room_select_1")
      end

      check "same_room"
      click_button "Confirm"
      expect(Activity.find(4).sessions.count).to eq(3)
      expect(Activity.find(4).sessions.first.room.room_number).to eq("203")
      expect(Activity.find(4).sessions[1].room.room_number).to eq("203")
      expect(Activity.find(4).sessions[2].room.room_number).to eq("203")
      expect(page).to have_content("Successfully Created Activity")
    end

    it "should be successful when multiple activities" do
      within('form') do
        fill_in "name_New_1", with: "Robots in the gym"
        fill_in "description_1", with: "All about robots"
        select("SUB (921 S 8th Ave, Pocatello, ID 83209)", from: "location_select_1")
        fill_in "start_time_New_1", with: "9:30"
        fill_in "end_time_1", with: "10:30"
        select("102 (Cafe)", from: "room_select_1")
        fill_in "capacity_1", with: "3"
      end

      first(:xpath, "//button[@title='Add New Activity']").click

      within('form') do
        fill_in "name_New_2", with: "Python"
        fill_in "description_2", with: "Learn Python"
        select("SUB (921 S 8th Ave, Pocatello, ID 83209)", from: "location_select_2")
        select("102 (Cafe)", from: "room_select_2")
        fill_in "start_time_New_2", with: "5:30"
        fill_in "end_time_2", with: "6:30"
        fill_in "capacity_2", with: "3"
      end

      click_button 'Confirm'
      expect(page).to have_content("Successfully Created Activity")
    end

  end

  context "update an activity" do
    before(:each) do
      @coordinator = User.find(9)
      @event = Event.first
      @activity = Activity.first
      # log in
      login_as(@coordinator)
      visit edit_activity_path(event_id: @event.id, id: @activity.id)
    end

    it "should be successful when name is updated" do
      # fill form
      within('form') do
        fill_in "name_New_1", with: "Droids"
      end
      click_button "Confirm"
      expect(Activity.first.name).to eq("Droids")
      expect(page).to have_content("Successfully Updated Activity.")
    end

    it "should be successful when description is updated" do
      # fill form
      within('form') do
        fill_in "description_1", with: "Program"
      end
      click_button "Confirm"
      expect(Activity.first.description).to eq("Program")
      expect(page).to have_content("Successfully Updated Activity.")
    end

    it "should be successful when iscompetetion is updated" do
      within('form') do
        check "iscompetetion_1"
      end
      click_button "Confirm"
      expect(Activity.first.iscompetetion).to eq(true)
      expect(page).to have_content("Successfully Updated Activity.")
    end

    it "should be successful when session time is updated" do
      within("form") do
        fill_in "start_time_New_1", with: "10:30"
        fill_in "end_time_1", with: "11:30"
      end
      click_button "Confirm"
      start_time = Time.new(2020, 3, 30, 10, 30, 0, "-06:00")
      end_time = Time.new(2020, 3, 30, 11, 30, 0, "-06:00")
      expect(Activity.first.sessions.first.start_time.hour).to eq(start_time.hour)
      expect(Activity.first.sessions.first.end_time.hour).to eq(end_time.hour)
    end

    it "should be successful when session capacity is updated" do
      within("form") do
        fill_in "capacity_1", with: "5"
      end
      click_button "Confirm"
      sleep(2)
      expect(Activity.first.sessions.first.capacity).to eq(5)
    end

    it "should be successful when session room is updated" do
      within("form") do
        select("203 (Ballroom)", from: "room_select_1")
      end
      click_button "Confirm"
      expect(Activity.first.sessions.first.room.room_number).to eq("203")
    end

    it "should be successful when a new session is added" do
      first(".new-session").click
      within("form") do
        select("203 (Ballroom)", from: "room_select_6")
        fill_in "start_time_6", with: "7:30"
        fill_in "end_time_6", with: "8:30"
        fill_in "capacity_6", with: "3"
      end
      sleep 2
      click_button "Confirm"
      expect(page).to have_content("Successfully Updated Activity.")
      expect(Activity.first.sessions.count).to eq(3)
    end

  end

  context "delete activity" do
    before(:each) do
      @coordinator = User.find(8)
      # log in
      login_as(@coordinator)
      visit profile_path(@coordinator)
    end

    it "should be successful" do
      find(".table").first(".btn-danger").click
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content "Successfully Deleted Activity."
    end
  end

  context "activities over time" do
    it "coordinator/admin can see activities report" do
      pending("...")
      fail
    end

    it "choose a date to see activities successful" do
      pending("...")
      fail
    end

    it "if there is no event with date then no activities will load" do
      pending("...")
      fail
    end

    it "activity will show all activities with the same identifier" do
      pending("...")
      fail
    end
  end
  # context "download spreadsheets" do
  #   before(:each) do
  #     DOWNLOAD_PATH = Rails.root.join("tmp/downloads").to_s
  #
  #
  #     Capybara.register_driver :selenium do |app|
  #       options = Selenium::WebDriver::Chrome::Options.new
  #
  #       options.add_argument('--headless')
  #       options.add_argument('--no-sandbox')
  #       options.add_argument('--disable-gpu')
  #       options.add_argument('--disable-popup-blocking')
  #       options.add_argument('--window-size=1366,768')
  #
  #       options.add_preference(:download, directory_upgrade: true,
  #                              prompt_for_download: false,
  #                              default_directory:
  #                                  DOWNLOAD_PATH)
  #
  #       options.add_preference(:browser, set_download_behavior: {behavior: 'allow'})
  #
  #       driver = Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  #
  #       bridge = driver.browser.send(:bridge)
  #
  #       path = '/session/:session_id/chromium/send_command'
  #       path[':session_id'] = bridge.session_id
  #
  #       bridge.http.call(:post, path, cmd: 'Page.setDownloadBehavior',
  #                        params: {
  #                            behavior: 'allow',
  #                            downloadPath: DOWNLOAD_PATH
  #                        })
  #
  #       driver
  #     end
  #
  #     @coordinator = User.find(9)
  #     login_as(@coordinator)
  #     visit profile_path(@coordinator)
  #   end
  #
  #   it "should be successful" do
  #     first(".event-collapse").click
  #     first(:xpath, ".//a[@title='Download activity spread sheet']").click
  #     # page.response.headers["Content-Disposition"].should include("filename=\"#{Activity.first.name}\"")
  #     sleep 10
  #     full_path = DOWNLOAD_PATH + "/Robotics.xlsx"
  #     expect(File.exist?(full_path)).to eq(true)
  #   end
  # end
end
