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
