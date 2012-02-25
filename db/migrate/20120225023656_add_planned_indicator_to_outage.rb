class AddPlannedIndicatorToOutage < ActiveRecord::Migration
  def self.up
    add_column :outages, :reason, :string
  end

  def self.down
    remove_column :outages, :reason
  end
end