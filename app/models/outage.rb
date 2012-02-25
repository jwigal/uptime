class Outage < ActiveRecord::Base
  def self.uptime(date)
    seconds = Time.zone.now - date
    minutes = seconds / 60
    (minutes - where(["date >= ?", date]).sum(:minutes)) / minutes
  end
  
  
  def title
    "#{reason} (#{length_string})"
  end
  
  def length_string
    minutes < 120 ? "#{minutes} mins" : "#{minutes / 60} hrs"
  end
  
  def start
    date.to_s("%Y-%m-%d")
  end
end
