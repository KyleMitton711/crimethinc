Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Format webserver logs in Logstash formatted JSON using Lograge
  config.lograge.enabled   = true
  config.lograge.formatter = Lograge::Formatters::Logstash.new

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Configure memcache as the cache_store if available
  # Pulled from https://devcenter.heroku.com/articles/memcachedcloud
  config.cache_store = if ENV['MEMCACHEDCLOUD_SERVERS']
                         [
                           :dalli_store,
                           ENV['MEMCACHEDCLOUD_SERVERS'].split(','),
                           {
                             username: ENV['MEMCACHEDCLOUD_USERNAME'],
                             password: ENV['MEMCACHEDCLOUD_PASSWORD']
                           }
                         ]
                       else
                         # Cache in memory otherwise
                         [:memory_store, { size: 64.megabytes }]
                       end

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Compress CSS using a preprocessor.
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = 'http://assets.example.com'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = 'X-Sendfile' # for Apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for NGINX

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :production

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [:request_id]

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = [I18n.default_locale]

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Background jobs
  config.active_job.queue_adapter = :sidekiq

  # TODO: Extract to ENV var in .env and staging/production environments
  # For using #url_for et al in non-views/helpers
  Rails.application.routes.default_url_options[:host] =
    if ENV['ON_STAGING'] == 'TRUE'
      'crimethincstaging.com'
    else
      'crimethinc.com'
    end
end
