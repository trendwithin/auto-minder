class GeoTagVehicle < ApplicationRecord
  belongs_to :user

  validates :license_plate, presence: true, length: { in: 1..7 }
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :state, presence: true
end
