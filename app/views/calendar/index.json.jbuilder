json.array!(@outages) do |json, outage|
  json.extract! outage, :id, :title, :start
end
