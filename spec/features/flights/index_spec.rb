require 'rails_helper'

RSpec.describe "Flights Index Page" do
  it "see a list of all flight numbers" do
    southwest = Airline.create(name: "Southwest")

    southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
    southwest_2 = southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")

    visit "/flights"

    within "#flight-#{southwest_1.id}" do
      expect(page).to have_content("Flight Number: #{southwest_1.number}")
    end

    within "#flight-#{southwest_2.id}" do
      expect(page).to have_content("Flight Number: #{southwest_2.number}")
    end
  end

  it "under each flight number I see the names of all that flights passengers" do
    southwest = Airline.create(name: "Southwest")

    southwest_1 = southwest.flights.create(number: "SW1", date: "10/10/20", time: "1300", departure_city: "Minneapolis", arrival_city: "Nashville")
    southwest_2 = southwest.flights.create(number: "SW2", date: "12/08/19", time: "0900", departure_city: "Baltimore", arrival_city: "Oakland")

    passenger_1 = southwest_1.passenger.create!(name: "Danny Moran", age: 26)
    passenger_1 = southwest_2.passenger.create!(name: "Danny Moran", age: 26)
    passenger_1 = southwest_2.passenger.create!(name: "Saul Moran", age: 2)

    visit "/flights"

    within "#flight-#{southwest_1.id}" do
      expect(page).to have_content("Flight Number: #{southwest_1.number}")
      expect(page).to have_content("Flight Number: #{passenger_1.name}")
    end

    within "#flight-#{southwest_2.id}" do
      expect(page).to have_content("Flight Number: #{southwest_2.number}")
      expect(page).to have_content("Flight Number: #{passenger_1.name}")
      expect(page).to have_content("Flight Number: #{passenger_2.name}")
    end
  end
end





  # User Story 1, Flights Index Page
  #
  # As a visitor
  # When I visit the flights index page ('/flights')
  # I see a list of all flight numbers
  # And under each flight number I see the names of all that flights passengers
