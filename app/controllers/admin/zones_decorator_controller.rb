Admin::ZonesController.class_eval do
  def load_data
    @countries = Country.order(:name)
    @states = State.order(:name)
    @zones = Zone.where(:domain_url=>current_user.domain_url).order(:name)
  end
end