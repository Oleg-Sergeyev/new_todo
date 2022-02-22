# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
# require "active_storage/engine"
require 'action_controller/railtie'
require 'action_mailer/railtie'
# require "action_mailbox/engine"
# require "action_text/engine"
require 'action_view/railtie'
# require "action_cable/engine"
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Todo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"

    # config.eager_load_paths << Rails.root.join('lib/classes')
    # config.eager_load_paths << Rails.root.join('/services')

    # config.paths.add config.root.join('app', 'api', 'helpers').to_s, eager_load: true, recursive: true
    # config.paths.add config.root.join('app/api/**/').to_s, eager_load: true, recursive: true
    # config.paths.add config.root.join('app', 'api', 'entities').to_s, eager_load: true, recursive: true
    # config.autoload_paths += Dir["#{Rails.root}/app/api/**/"]
    # config.eager_load_paths += Dir["#{Rails.root}/app/api/**/"]
    # config.eager_load_paths << Rails.root.join('app', 'api', 'helpers')
    # config.eager_load_paths << Rails.root.join('app', 'api', 'entities')

    # config.paths.add Rails.root.join('lib').to_s, eager_load: true
    # config.paths.add Rails.root.join('app', 'api', 'helpers').to_s, eager_load: true
    # config.paths.add Rails.root.join('app', 'api', 'entities').to_s, eager_load: true
    # config.autoload_paths += Dir["#{config.root}/app/**/"]

    # config.autoload_paths += %W(#{config.root}/app/env)
    # config.paths.add Rails.root.join('lib').to_s, eager_load: true
    # config.paths.add Rails.root.join('app/api/helpers').to_s, eager_load: true
    config.eager_load_paths << "#{Rails.root}/lib"
    config.eager_load_paths << "#{Rails.root}/app/api/entities/**"
    # config.assets.paths << Rails.root.join("app", "api", "helpers")

    config.eager_load_paths << Rails.root.join('lib/classes')
    config.eager_load_paths << Rails.root.join('/services')

    # config.eager_load_paths += %W( #{config.root}/api/lib )

    # config.autoload_paths << "#{Rails.root}/app/api/**/"
    # config.eager_load_paths << "#{Rails.root}/app/api/**/"

    # config.eager_load_paths << Rails.root.join('app', 'api', 'methods')
    # config.paths.add File.join('app', 'api', 'helpers'), glob: File.join('**', '*.rb')

    # require_dependency Rails.root.join('app/api/helpers/')
    # config.autoload_paths += Dir["#{config.root}/app/api/entities/**/"]
    # config.paths.add File.join('app', 'api'), glob: File.join('**', '*.rb')
    # config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]
    # config.autoloader = :classic
    # config.eager_load = true
    # config.eager_load_paths << "#{Rails.root}/app/api/**"
    # config.autoloader = :classic
    config.i18n.available_locales = %i[en ru]
    config.i18n.default_locale = :ru
    config.time_zone = 'Moscow'

    # config.active_record.default_timezone = :utc
    # Don't generate system test files.
    config.generators.system_tests = nil
    # Don't generate system test files.
    config.generators do |g|
      g.org             :active_record
      g.template_engine :slim
      g.system_tests    nil
      g.test_framework  nil
      g.helper          false
      g.stylesheets     false
      g.javascript      false
      g.factory_bot     dir: 'spec/factories'
    end
  end
end
