@outages.each do |outage|
  json.child! {|json| json.extract! outage, :id, :title, :start}
end