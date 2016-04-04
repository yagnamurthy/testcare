require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module Carespotter
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller


    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

    config.exceptions_app = self.routes

    config.autoload_paths += Dir["#{Rails.root}/lib/**"]

    config.assets.paths << Rails.root.join("app", "assets", "documents")

    config.serve_static_files = false


    # config.autoload_paths += Dir["#{Rails.root}/models/caregiver/**"]=

    # config.eager_load_paths += ["#{Rails.root}/models/caregiver/**}"]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.active_job.queue_adapter = :sidekiq

    GC::Profiler.enable
  end
end
