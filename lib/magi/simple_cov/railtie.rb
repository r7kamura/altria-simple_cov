require "rails/railtie"

module Magi
  module SimpleCov
    class Railtie < Rails::Railtie
      initializer "magi.simple_cov.set_autoload_paths", before: :set_autoload_paths do |app|
        app.config.autoload_paths << File.expand_path("../../../", __FILE__)
      end

      config.after_initialize do
        require "magi/simple_cov/initializer"
      end
    end
  end
end
