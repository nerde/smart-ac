# frozen_string_literal: true

Given('the following users:') do |table|
  User.create!(table.hashes)
end
