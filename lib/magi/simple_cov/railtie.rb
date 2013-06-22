require "rails/railtie"

module Magi
  module SimpleCov
    class Railtie < Rails::Railtie
      config.after_initialize do
        require "magi/simple_cov/initializer"
      end
    end
  end
end
