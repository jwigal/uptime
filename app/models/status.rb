class Status < ActiveRecord::Base
  belongs_to :category
  belongs_to :service
  validates_presence_of :category
  
  delegate :image_path, :to => :category
  def self.create_with_exception(e, serv)
    category = Category.where(:is_public => false, :is_down => true).first
    serv.statuses.create(:category => category, :title => e.class.to_s, 
    :description => ([e.message] + e.backtrace).join("\n"))
  end
  
  def formatted_date
    updated_at.strftime("%A, %B %d").gsub(/ 0/,' ')
  end
  
  def formatted_time
    updated_at.strftime("%l:%M %Z").gsub(/( 0|^0|^ )/,' ') + 
    " (#{created_at.utc.strftime("%H:%M")} UTC)"
    

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
