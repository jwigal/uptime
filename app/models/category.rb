class Category < ActiveRecord::Base
  has_many :statuses
  validates_uniqueness_of :name
  
  def self.published
    where(:is_public => true)  
  end

  def self.unpublished
    where(:is_public => false)    
  end
  
  def self.up
    where(:is_up => true)
  end
  
  def self.down
    where(:is_down => true)  
  end
  
end
