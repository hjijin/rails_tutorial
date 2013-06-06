RailsTutorial::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  # Log error messages when you accidentally call methods on nil
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  # Speed up tests by lowering BCrypt's cost function.
  # 使用 Factory Girl 后，明显可以察觉测试变慢了，这不是 Factory Girl 导致的，而是有意为之，并不是 bug。
  # 变慢的原因在于用来加密密码的 BCrypt，其加密算法设计如此，因为慢速加密的密码很难破解。
  # 慢速加密的过程会延长测试的运行时间，不过我们可以做个简单的设置改变这种情况。
  # BCrypt 使用耗时因子（cost factor）设定加密过程的耗时，耗时因子的默认值倾向于安全性而不是速度，在生产环境这种设置很好，
  # 但测试时的关注点却有所不同：测试追求的是速度，而不用在意测试数据库中用户的密码强度。
  # 我们可以在“测试环境”配置文件 config/environments/test.rb 中加入几行代码来解决速度慢的问题：把耗时因子的默认值修改为最小值，提升加密的速度，
  # 即使测试量很少，修改设置之后速度的提升也是很明显的。
  require 'bcrypt'
  silence_warnings do
    BCrypt::Engine::DEFAULT_COST = BCrypt::Engine::MIN_COST
  end
end
