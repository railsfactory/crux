
class CreateBillingHistories < ActiveRecord::Migration
  def self.up
    create_table :billing_histories do |t|
      t.integer :store_owner_id
			t.integer :amount
			t.date :billing_date
			t.string :payment_type
			t.string :transaction_id
 			t.string :acknowledge
      t.timestamps
    end
  end

  def self.down
    drop_table :billing_histories
  end
end
