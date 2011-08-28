class Service < ActiveRecord::Base
  has_many :statuses, :order => "statuses.created_at desc"
  def current_status
    statuses.first
  end
  
  
  def check
    begin
      Timeout::timeout(30) do
        page = agent.get(url)
        raise(InvalidResponseCode, 
          "Page returned #{page.response["status"]}") unless page.response["status"] == "200"
        page
      end
    rescue Exception => e
      Status.create_with_exception(e, self)
    end
  end
  
  def check_for_24_hour_uptime
    return false if Status.today.down.count > 0
    statuses.create( :category => Category.up, :title => "All systems running, 24 hour up-time.")
  end
  
  private
  
  def agent
    @mechanize ||= Mechanize.new
  end
  
  class InvalidResponseCode < NoMethodError ; end
  
end
