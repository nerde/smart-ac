# frozen_string_literal: true

Then('I should receive a {string} response') do |status|
  expect(last_response.status).to eq(status.to_i)
end
