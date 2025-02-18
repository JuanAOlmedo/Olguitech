require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Olguitech
    class Application < Rails::Application
        # Initialize configuration defaults for originally generated Rails version.
        config.load_defaults 8.0

        # config/application.rb
        config.assets.initialize_on_precompile = false

        config.i18n.fallbacks = true

        config.i18n.available_locales = %i[es en]
        config.i18n.default_locale = :es

        config.annotations.register_tags('TRANSLATE')

        # Please, add to the `ignore` list any other `lib` subdirectories that do
        # not contain `.rb` files, or that should not be reloaded or eager loaded.
        # Common ones are `templates`, `generators`, or `middleware`, for example.
        config.autoload_lib(ignore: %w[assets tasks])

        # Settings in config/environments/* take precedence over those specified here.
        # Application configuration can go into files in config/initializers
        # -- all .rb files in that directory are automatically loaded after loading
        # the framework and any gems in your application.

        # Version of your assets, change this if you want to expire all your assets
        config.assets.version = '1.0'

        config.before_configuration do
            env_file = File.join(Rails.root, 'config', 'local_env.yml')

            YAML.load(File.open(env_file))
                .each { |key, value| ENV[key.to_s] = value } if File.exist?(env_file)
        end
    end
end
