require 'rails_helper'

RSpec.describe FlightPassenger, type: :model do
  describe 'validations' do
    it {should validate_presence_of :flight_id}
    it {should validate_presence_of :passenger_id}
  end

  describe 'relationships' do
    it {should belong_to :flight}
    it {should belong_to :passenger}
  end
end
