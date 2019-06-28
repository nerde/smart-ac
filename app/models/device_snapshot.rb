class DeviceSnapshot < ApplicationRecord
  belongs_to :device

  validates :taken_at, :temperature_celsius, :humidity_percentage, :carbon_monoxide_ppm, :status, presence: true
end
