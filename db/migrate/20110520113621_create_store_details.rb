class CreateStoreDetails < ActiveRecord::Migration
  def self.up
    create_table :store_details do |t|
			t.string :domain_url   
      t.integer :product_id
      t.integer :quantity    
      t.timestamps
    end
  end

  def self.down
    drop_table :store_details
  end
end
