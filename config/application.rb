require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cranify
  class Application < Rails::Application
    # Autoload lib dir
    config.autoload_paths << Rails.root.join("lib")

    # CRAN package URL
    config.cran_package_url = "http://cran.r-project.org/src/contrib"
    # CRAN packages url
    config.cran_packages_url = "#{config.cran_package_url}/PACKAGES"
  end
end
