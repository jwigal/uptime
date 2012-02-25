class Outage < ActiveRecord::Base
  def self.uptime(date)
    seconds = Time.zone.now - date
    minutes = seconds / 60
    (minutes - where(["date >= ?", date]).sum(:minutes)) / minutes
  end
  
end
