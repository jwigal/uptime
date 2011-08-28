class RemoveRedundantCategoryFields < ActiveRecord::Migration
  def self.up
    remove_column :categories, :is_online
    remove_column :categories, :is_offline
  end

  def self.down
    add_column :categories, :is_offline, :boolean
    add_column :categories, :is_online, :boolean
  end
end
