class CreateStoreownerOrders < ActiveRecord::Migration
  def self.up
    create_table :storeowner_orders do |t|
			t.integer :store_owner_id
			t.integer :order_id
      t.timestamps
    end
  end

  def self.down
    drop_table :storeowner_orders
  end
end
