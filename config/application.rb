require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module BitcoinPool
  class Application < Rails::Application
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml')]
    config.i18n.default_locale = :en

    # JavaScript files you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions[:defaults] = %w(jquery rails jqplot jqplot.dateAxisRenderer jqplot.highlighter excanvas)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.autoload_paths << File.join(config.root, "lib")
    config.autoload_paths << File.join(config.root, "lib", "bitcoin")
    config.autoload_paths << File.join(config.root, "lib", "validators")
  end
end
