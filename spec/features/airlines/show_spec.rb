require 'rails_helper'

RSpec.describe "Airline Show Spec" do
  describe "When I visit the airline show page" do
    before :each do
      @southwest = Airline.create(name: "Southwest")

      @southwest_1 = @southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
      @southwest_2 = @southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")

      @passenger_1 = @southwest_1.passengers.create!(name: "Danny Moran", age: 26)
      @passenger_2 = @southwest_2.passengers.create!(name: "Saul Moran", age: 2)
      @passenger_3 = @southwest_2.passengers.create!(name: "Danny Moran", age: 26)
    end
    it 'I can see that airlines name and all its flights' do

      visit "/airlines/#{@southwest.id}"

      expect(page).to have_content(@southwest.name)

      within "#flight-#{@southwest_1.id}" do
        expect(page).to have_content("Flight Number: #{@southwest_1.number}")
        expect(page).to have_content("Date: #{@southwest_1.date}")
        expect(page).to have_content("Time: #{@southwest_1.time}")
        expect(page).to have_content("Departure City: #{@southwest_1.departure_city}")
        expect(page).to have_content("Arrival City: #{@southwest_1.arrival_city}")
      end

      within "#flight-#{@southwest_2.id}" do
        expect(page).to have_content("Flight Number: #{@southwest_2.number}")
        expect(page).to have_content("Date: #{@southwest_2.date}")
        expect(page).to have_content("Time: #{@southwest_2.time}")
        expect(page).to have_content("Departure City: #{@southwest_2.departure_city}")
        expect(page).to have_content("Arrival City: #{@southwest_2.arrival_city}")
      end
    end

    it "see a unique list of passengers that have flights from that airline" do
      visit "/airlines/#{@southwest.id}"
      save_and_open_page

      within "#passengers" do
        expect(page).to have_content("#{passenger_2.name}")
        expect(page).to have_content("#{passenger_1.name}")
      end
    end
  end
end
