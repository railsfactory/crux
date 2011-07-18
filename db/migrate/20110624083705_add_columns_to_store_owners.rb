class AddColumnsToStoreOwners < ActiveRecord::Migration
  def self.up
    add_column :storeowner_orders, :is_custom, :boolean
  end

  def self.down
    remove_column :storeowner_orders, :is_custom
  end
end
