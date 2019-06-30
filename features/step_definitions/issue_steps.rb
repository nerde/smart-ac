# frozen_string_literal: true

Then('I should have the following issues:') do |table|
  issues = Issue.order(:id).map(&:attributes)

  add_association_column(table, issues, 'device', &:serial_number)

  table.map_column!(:occurred_at, false) { |raw| Time.zone.parse(raw) }

  table.diff!(issues)
end

Then('I should have no issues') do
  expect(Issue.count).to eq(0)
end
