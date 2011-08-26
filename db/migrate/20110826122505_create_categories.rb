class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.boolean :is_online
      t.boolean :is_offline

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
