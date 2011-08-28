class AddServiceToStatus < ActiveRecord::Migration
  def self.up
    add_column :statuses, :service_id, :integer
  end

  def self.down
    remove_column :statuses, :service_id
  end
end