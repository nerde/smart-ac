# frozen_string_literal: true

Then('I should have the following device snapshots:') do |table|
  snapshots = DeviceSnapshot.order(:id).map do |snap|
    snap.attributes.merge(
      'temperature_celsius' => snap.temperature_celsius.to_s,
      'humidity_percentage' => snap.humidity_percentage.to_s,
      'carbon_monoxide_ppm' => snap.carbon_monoxide_ppm.to_s
    )
  end

  add_association_column(table, snapshots, 'device', &:serial_number)

  table.map_column!(:taken_at, false) { |raw| Time.parse(raw) }

  table.diff!(snapshots)
end
