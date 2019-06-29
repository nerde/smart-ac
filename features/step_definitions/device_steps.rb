# frozen_string_literal: true

Given('the following devices:') do |table|
  Device.create!(table.hashes)
end

When('I create the following device:') do |table|
  post devices_path, table.rows_hash
end

When('device {string} reports the following snapshot:') do |auth_token, table|
  header 'Token', auth_token
  post device_snapshots_path, table.rows_hash
end

Then('I should have the following devices:') do |table|
  devices = Device.order(:id).map(&:attributes)

  table.diff!(devices)
end
