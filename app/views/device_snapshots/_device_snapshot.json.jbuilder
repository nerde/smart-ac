# frozen_string_literal: true

json.extract! device_snapshot, :id, :taken_at, :temperature_celsius, :humidity_percentage, :carbon_monoxide_ppm, :status
