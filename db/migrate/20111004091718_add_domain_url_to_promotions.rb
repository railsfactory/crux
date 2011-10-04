class AddDomainUrlToPromotions < ActiveRecord::Migration
  def self.up
		add_column :promotions,:domain_url,:string
  end

  def self.down
	add_column :promotions,:domain_url,:string
  end
end
