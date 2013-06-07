# source 'https://rubygems.org'
source 'http://ruby.taobao.org'

gem 'rails', '3.2.13'
gem 'bootstrap-sass', '2.3.1.3'
gem 'bcrypt-ruby', '3.0.1' # 加密密码 User 数据结构做些改动，向 users 表中加入 password_digest 列
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
group :development, :test do
  gem 'mysql2'
  gem 'rspec-rails', '2.11.0'
  gem 'guard-rspec'
  gem 'growl', '1.0.3'
  gem 'guard-spork', '1.5.0'
  gem 'spork', '0.9.2'
  gem 'annotate', '2.5.0'
end

gem 'multi_json', '1.7.3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '2.0.2'

group :test do
  gem 'capybara', '1.1.2' #编写模拟与应用程序交互的代码
  # Mac OS X 中需要的测试组 gem
  gem 'rb-fsevent', '0.9.3', :require => false
  gem 'factory_girl_rails', '4.2.1' # 添加 spec/factories.rb
end

group :production do
  gem 'pg', '0.12.2'
  gem 'rails_log_stdout',           github: 'heroku/rails_log_stdout'
  gem 'rails3_serve_static_assets', github: 'heroku/rails3_serve_static_assets'
end
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
