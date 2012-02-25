class CalendarController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json do
        @outages = Outage.where(["date >= ?", 1.year.ago])
      end
    end
  end

end
