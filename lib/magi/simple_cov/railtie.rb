require "rails/engine"

module Magi
  module SimpleCov
    class Railtie < Rails::Engine
      initializer "magi.simple_cov.set_autoload_paths", before: :set_autoload_paths do |app|
        app.config.autoload_paths << File.expand_path("../../../", __FILE__)
        app.config.autoload_paths << File.expand_path("../../../../app/views", __FILE__)
      end

      config.after_initialize do
        require "magi/simple_cov/initializer"
      end
    end
  end
end
