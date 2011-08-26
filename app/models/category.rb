class Category < ActiveRecord::Base
  has_many :statuses
end
