class CalendarController < ApplicationController
  def index
    @outages = Outage.where(["date >= ?", 1.year.ago]).all
    respond_to do |format|
      format.html do
        @dates = (1..12).collect do |i| 
          (Time.zone.local(Time.zone.now.year, i,1) if Time.zone.local(Time.zone.now.year, i,1).end_of_month  <= Time.zone.now.end_of_month) ||
          Time.zone.local(Time.zone.now.year-1, i,1)
        end
        @uptime = {3 => Outage.uptime(3.months.ago) * 100.0}
        @uptime[6] = Outage.uptime( 6.months.ago) * 100.0
        @uptime[12] = Outage.uptime( 12.months.ago) * 100.0
      end
      format.json
    end
  end

end
