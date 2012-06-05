# This migration comes from spree (originally 20110520113621)
class CreateStoreDetails < ActiveRecord::Migration
  def self.up
    create_table :spree_store_details do |t|
			t.string :domain_url
      t.integer :product_id
      t.integer :quantity
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_store_details
  end
end
