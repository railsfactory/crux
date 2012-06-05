# This migration comes from spree (originally 20110628140239)
class CreateDomainCustomizes < ActiveRecord::Migration
  def self.up
    create_table :spree_domain_customizes do |t|
      t.string :store_owner_id
      t.string :custom_domain
      t.boolean :status

      t.timestamps
    end
  end

  def self.down
    drop_table :spree_domain_customizes
  end
end
