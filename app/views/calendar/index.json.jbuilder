@outages.each do |outage|
  json.extract! outage, :id, :title, :start
end