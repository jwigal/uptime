# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
Category.create :name => "Up (Automated)", :is_public => false, :is_up => true, :is_down => false
Category.create :name => "Down (Automated)", :is_public => false, :is_up => false, :is_down => true
Category.create :name => "Info", :is_public => true, :image_path => "information.png"
Category.create :name => "Up", :is_public => true, :is_up => true, :is_down => false, :image_path => "accept.png"
Category.create :name => "Down", :is_public => true, :is_up => false, :is_down => true, :image_path => "cross.png"
Service.create :name => "assignr.com", :url => "https://assignr.com/login"