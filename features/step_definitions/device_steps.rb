# frozen_string_literal: true

When('I create the following device:') do |table|
  post devices_path, table.rows_hash
end

Then('I should have the following devices:') do |table|
  devices = Device.order(:id).map(&:attributes)

  table.diff!(devices)
end
