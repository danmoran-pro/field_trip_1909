class FlightPassenger < ApplicationRecord
  validates_presence_of :flight_id,
                        :passenger_id
  belongs_to :flight
  belongs_to :passenger
end
