require File.dirname(__FILE__) + '/../test_helper'

class CategoryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  
  # def self.published
  #   where(:is_public => true)  
  # end
  # 
  # def self.unpublished
  #   where(:is_public => false)    
  # end
  # 
  # def self.up
  #   where(:is_up => true)
  # end
  # 
  # def self.down
  #   where(:is_down => true)  
  # end

  should "published scope includes a published category" do
    c = Category.first
    c.is_public = true
    c.save!
    assert Category.published.include?( c    )
  end
  
  should "unpublished scope includes an unpublished category" do
    c = Category.first
    c.is_public = false
    c.save!
    assert Category.unpublished.include?( c    )    
  end

  should "up scope includes an is_up category" do
    c = Category.first
    c.is_up = true
    c.save!
    assert Category.up.include?( c    )    
  end


  should "down scope includes an is_down category" do
    c = Category.first
    c.is_down = true
    c.save!
    assert Category.down.include?( c    )    
  end

  
end
