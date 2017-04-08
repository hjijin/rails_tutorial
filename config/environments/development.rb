Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    # 页面缓存
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false
    # 缓存路径
    # config.action_controller.page_cache_directory = "#{Rails.root.to_s}/public"

    config.cache_store = :null_store
  end

  # Rails 使用sprockets-rails 来管理 app/assets 中的文件: http://localhost:3000/assets/logo-be2e3e66a18126c4042f84cd4aae4cb3.png
  # 关闭 be2e3e66a18126c4042f84cd4aae4cb3 这种形式：
  # config.assets.digest = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
    host = 'rails5app.com'
    config.action_mailer.default_url_options = { host: host }
    ActionMailer::Base.smtp_settings = {
      :address        => 'smtp.gmail.com',
      :port           => '587',
      :authentication => :plain,
      :user_name      => ENV['GMAIL_USERNAME'],
      :password       => ENV['GMAIL_PASSWORD'],
      :domain         => 'gmail.example.com',
      :enable_starttls_auto => true
    }

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
