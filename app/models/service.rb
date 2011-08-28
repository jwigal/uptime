class Service < ActiveRecord::Base
  has_many :statuses, :order => "statuses.created_at desc"
  delegate :image_path, :is_down, :is_up, :is_up?, :is_down?, :to => :current_status
  
  def current_status
    statuses.includes(:service, :category).first
  end
  
  def self.should_be_notified?
    down_for_fifteen_minutes? && !acknowledged_down_time?
  end
  
  def self.is_down?
    all.any?(&:is_down?)
  end
  
  def self.acknowledged_down_time?
    Status.down.acknowledged.in_last_hour.count > 0
  end

  def self.down_for_fifteen_minutes?
    is_down? && 
    Status.down.in_last_fifteen_minutes.count > 0 && 
    Status.up.in_last_fifteen_minutes.count = 0
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
  
  def self.check_for_24_hour_uptime
    Service.all.each &:check_for_24_hour_uptime
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
