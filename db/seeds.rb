
User.create!(email: 'admin@smartac.com', password: '123456789') if User.none?

if ENV['SAMPLE_DATA'] == '1'
  device = Device.first || Device.create!(name: 'Sample Device', serial_number: '12345', firmware_version: '1.0')

  if device.snapshots.none?
    since = 7.days.ago
    minutes = 7 * 24 * 60
    status = %w[ok needs_service needs_new_filter gas_leak]
    minutes.times do |n|
      snap = device.snapshots.create!(taken_at: since + n.minutes, status: status.sample,
                                      temperature_celsius: (1500 + rand(1500)) / 100.0,
                                      humidity_percentage: (3500 + rand(2500)) / 100.0,
                                      carbon_monoxide_ppm: (4000 + rand(4000)) / 1000.0)

      snap.generate_issues
    end
  end
end
