class CreateOutages < ActiveRecord::Migration
  def self.up
    create_table :outages do |t|
      t.integer :minutes
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :outages
  end
end
