
class CreateStoreOwners < ActiveRecord::Migration
  def self.up
    create_table :store_owners do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :zipcode
      t.string :state
      t.string :country
      t.string :phone
      t.string :domain
      t.string :card_number
      t.string :card_type
      t.string :cvv
      t.string :expiration_year
      t.string :expiration_month
      t.integer :pricing_plan_id
      t.string :ip
      t.string :name
      t.integer :phoneno
      t.boolean :is_active,:default=>1
      t.string :transaction_id
      t.timestamps
    end
  end


  def self.down
    drop_table :store_owners
  end
end
