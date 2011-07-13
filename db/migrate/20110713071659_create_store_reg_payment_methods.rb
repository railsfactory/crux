class CreateStoreRegPaymentMethods < ActiveRecord::Migration
  def self.up
    create_table :store_reg_payment_methods do |t|
      t.string :username
			t.string :password
			t.string :signature
			t.timestamps
    end
  end

  def self.down
    drop_table :store_reg_payment_methods
  end
end
