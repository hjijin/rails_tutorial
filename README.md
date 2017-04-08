# Getting started
To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

## Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

### test gem:
	gem 'rails-controller-testing', '0.1.1'
	gem 'minitest-reporters', '1.1.9'
	gem 'guard', '2.14.0'
	gem 'guard-minitest', '2.4.5'

Rails 应用的测试适时显示红色和绿色(test/test_helper.rb):
	require "minitest/reporters"
	Minitest::Reporters.use!

### 使用 Guard 自动测试
	1.初始化: $ guard init
	2.配置好 Guardfile
	3.打开一个新终端窗口: $ guard

### sass 和 scss 写法上的不同
	两种文件间转换，可以使用这个命令：
		# Convert Sass to SCSS
		$ sass-convert style.sass style.scss

		# Convert SCSS to Sass
		$ sass-convert style.scss style.sass

### 常用的表单辅助方法

使用 form_tag 的同时，我们还需要一些辅助方法来生成表单控件。

```
	<%= text_area_tag(:message, "Hi, nice site", size: "24x6") %>
	<%= password_field_tag(:password) %>
	<%= hidden_field_tag(:parent_id, "5") %>
	<%= search_field(:user, :name) %>
	<%= telephone_field(:user, :phone) %>
	<%= date_field(:user, :born_on) %>
	<%= datetime_field(:user, :meeting_time) %>
	<%= datetime_local_field(:user, :graduation_day) %>
	<%= month_field(:user, :birthday_month) %>
	<%= week_field(:user, :birthday_week) %>
	<%= url_field(:user, :homepage) %>
	<%= email_field(:user, :address) %>
	<%= color_field(:user, :favorite_color) %>
	<%= time_field(:task, :started_at) %>
	<%= number_field(:product, :price, in: 1.0..20.0, step: 0.5) %>
	<%= range_field(:product, :discount, in: 1..100) %>
```