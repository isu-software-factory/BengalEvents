require 'rails_helper'
require 'gas_load_tester'
require 'rest-client'

RSpec.feature "LoadTests", type: :feature do
  context 'first tests' do
    before(:each) do
      RestClient.log = STDOUT
    end
    it 'should pass' do
      ActionController::Base.allow_forgery_protection = false
      stuff = []
      simple_test = GasLoadTester::Test.new({client: 100, time: 10})
      simple_test.run(output: true, file_name: 'load_results.html') do
        response = RestClient.get('localhost:3000/homeroutes/home')
        stuff << response
      end

      stuff.each do |s|
        expect(s.body.include?('Bengal Stem Day')).to eq(true)
        puts s
      end

    end
  end
end

