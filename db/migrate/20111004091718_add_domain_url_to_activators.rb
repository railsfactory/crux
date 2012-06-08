class AddDomainUrlToActivators < ActiveRecord::Migration
  def self.up
		add_column :spree_activators,:domain_url,:string
  end

  def self.down
	add_column :spree_activators,:domain_url,:string
  end
end
