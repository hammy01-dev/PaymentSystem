# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PaymentSystem
  class Application < Rails::Application
    config.load_defaults 5.2
    config.autoload_paths += %W(#{config.root}/app/services)
    config.eager_load_paths << Rails.root.join('lib')
  end
end
