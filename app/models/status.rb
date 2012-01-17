class Status < ActiveRecord::Base
  belongs_to :category
  belongs_to :service
  validates_presence_of :category, :service
  
  delegate :image_path, :is_down, :is_up, :is_up?, :is_down?, :is_public?, :is_public, :to => :category

  # Given an exception, and a service, create an unpublished "we're offline" status
  def self.create_with_exception(e, serv)
    category = Category.unpublished.down.first
    serv.statuses.create(:category => category, :title => e.class.to_s, 
    :description => ([e.message] + e.backtrace).join("\n"))
  end
  
  def self.in_last_fifteen_minutes
    where(["created_at >= ?", 15.minutes.ago])
  end
  
  def self.in_last_hour
    where(["created_at >= ?", 60.minutes.ago])    
  end
  
  def up_status
    return unless is_down?
    service.statuses.up.where(["statuses.updated_at >= ? ", updated_at]).order("statuses.updated_at").first
  end
  
  def down_time
    return unless up_status
    (up_status.updated_at - updated_at) / 60
  end  
  
  def self.acknowledged
    where(:acknowledged => true)
  end
  
  def formatted_date
    updated_at.strftime("%A, %B %d").gsub(/ 0/,' ')
  end
  
  def formatted_time
    updated_at.strftime("%l:%M %p %Z").gsub(/( 0|^0|^ )/,' ') + 
    " (#{updated_at.utc.strftime("%H:%M")} UTC)"
  end
  
  def to_date
    updated_at.to_date
  end
  
  
  def self.for_public
    includes(:category).where(:categories => {:is_public => true})
  end
  
  def self.up
    includes(:category).where(:categories => {:is_up => true})    
  end
  
  def self.down
    includes(:category).where(:categories => {:is_down => true})        
  end
  
  def self.today
    where(["statuses.created_at >= ?", 1.day.ago])
  end
end
