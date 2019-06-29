Rack::Attack.throttle('block flooding device creation', limit: 5, period: 10) do |req|
  req.path == '/devices' && req.post? && req.ip
end
