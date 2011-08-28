class AddAckToStatus < ActiveRecord::Migration
  def self.up
    add_column :statuses, :acknowledged, :boolean
  end

  def self.down
    remove_column :statuses, :acknowledged
  end
end