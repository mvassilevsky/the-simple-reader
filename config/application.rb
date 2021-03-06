require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TheSimpleReader
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Autoload lib.
    config.autoload_paths << Rails.root.join('lib')

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Establish database connection on console startup.
    console do
      ActiveRecord::Base.connection
    end

    # Add more tags to the HTML sanitizer whitelist.
    config.action_view.sanitized_allowed_tags =
      Rails::Html::Sanitizer.safe_list_sanitizer.allowed_tags +
      ['video', 'iframe']

    # Use Sidekiq to run queued jobs.
    config.active_job.queue_adapter = :sidekiq
  end
end
