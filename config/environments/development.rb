require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Make code changes take effect immediately without server restart.
  config.enable_reloading = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing for better performance monitoring.
  config.server_timing = true

  # Enable/disable Action Controller caching. By default, caching is disabled.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Raise delivery errors for the mailer to debug email sending issues.
  config.action_mailer.raise_delivery_errors = true

  # Ensure emails are sent during development (useful for testing password reset).
  config.action_mailer.perform_deliveries = true

  # Cache mailer templates for performance.
  config.action_mailer.perform_caching = false

  # Mailer configuration for development environment.
  config.action_mailer.default_url_options = { host: "localhost", port: 3000 }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              "smtp.gmail.com",
    port:                 587,
    domain:               "localhost",
    user_name:            "mahmoudfalous@gmail.com",
    password:             "wsjo xhvi szoh xbee",
    authentication:       "plain",
    enable_starttls_auto: true
  }

  # Ensure emails are sent with the correct 'From' address.
  config.action_mailer.default_options = { from: "mahmoudfalous@gmail.com" }

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Annotate rendered views with filenames for easier debugging.
  config.action_view.annotate_rendered_view_with_filenames = true

  # Highlight code that enqueued background jobs in logs.
  config.active_job.verbose_enqueue_logs = true

  # Allow Rails API to generate URLs with `host` included.
  config.action_controller.default_url_options = { host: "http://localhost:3000" }

  # Uncomment to raise an error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Uncomment to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  # Raise an error when a before_action's only/except options reference missing actions.
  config.action_controller.raise_on_missing_callback_actions = true
end
