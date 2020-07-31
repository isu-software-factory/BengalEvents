require 'rails_helper'
require 'gas_load_tester'
require 'rest-client'

RSpec.feature "LoadTests", type: :feature do
    scenario 'sign_in page' do
      stuff = []
      simple_test = GasLoadTester::GroupTest.new([{client: 100, time: 30}, {client: 250, time: 30}])
      simple_test.run(output: true, file_name: 'load_tests/sign_in.html') do
        response = RestClient.get('localhost:3000/homeroutes/home')
        stuff << response
      end

      stuff.each do |s|
        expect(s.body.include?('Bengal Stem Day')).to eq(true)
        puts s
      end
    end

    scenario 'registration page' do
      stuff = []
      simple_test = GasLoadTester::GroupTest.new([{client: 100, time: 30}, {client: 250, time: 30}])
      simple_test.run(output: true, file_name: 'load_tests/registration_page.html') do
        response = RestClient.get('localhost:3000/events/index/Student/9')
        stuff << response
      end

      stuff.each do |s|
        expect(s.body.include?('Register')).to eq(true)
        puts s
      end
    end
end

