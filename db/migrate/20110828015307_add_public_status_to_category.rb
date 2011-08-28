class AddPublicStatusToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :is_public, :boolean
    add_column :categories, :is_up, :boolean
    add_column :categories, :is_down, :boolean
    add_column :categories, :image_path, :string
  end

  def self.down
    remove_column :categories, :image_path
    remove_column :categories, :is_down
    remove_column :categories, :is_up
    remove_column :categories, :is_public
  end
end