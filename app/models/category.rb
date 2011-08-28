class Category < ActiveRecord::Base
  has_many :statuses
  validates_uniqueness_of :name
  def self.up
    where(:is_up => true, :is_public => true).first
  end
  
  def self.down
    where(:is_down => true, :is_public => true).first    
  end
  
end
