path=RAILS_ROOT.split("sandbox")[0]
APP_CONFIG = YAML.load_file("#{path}saas/config/settings.yml")[RAILS_ENV]
