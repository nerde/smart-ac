# frozen_string_literal: true

Given('the following devices:') do |table|
  Device.create!(table.hashes)
end

When('I create the following device:') do |table|
  post devices_path, table.rows_hash.merge(format: :json)
end

When('I list devices') do
  visit root_path
  click_on 'List Devices'
end

When('filter devices by {string}') do |query|
  fill_in 'Search by serial number', with: query

  click_on 'Search'
end

When("I view device details for {string}") do |name|
  visit device_path(Device.find_by!(name: name))
end

Then('I should have the following devices:') do |table|
  devices = Device.order(:id).map(&:attributes)

  table.diff!(devices)
end

Then('I should see the following devices:') do |table|
  table.diff!(html_table_to_hashes)
end

Then("I should see the following device details:") do |table|
  expect(description_list_to_hash.merge('Name' => first('h1').text)).to eq(table.rows_hash)
end
