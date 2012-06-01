Spree::Admin::ZonesController.class_eval do
  def load_data
    @countries = Spree::Country.order(:name)
    @states = Spree::State.order(:name)
    @zones = Spree::Zone.where(:domain_url=>current_user.domain_url).order(:name)
  end
end