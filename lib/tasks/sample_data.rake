require 'faker'

namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
		Rake::Task['db:reset'].invoke
		# User.create!(	:name => "Example User", 
		# 							:email => "example@railstutorial.org", 
		# 							:password => "foobar", 
		# 							:password_confirmation => "foobar",
		# 							:admin => true )
		admin = User.create!(	:name => "Example User", 
									:email => "example@railstutorial.org", 
									:password => "foobar", 
									:password_confirmation => "foobar")
		admin.toggle!(:admin)
		
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@gmail.com"
			password = "password"
			password_confirmation = "password"
			User.create!(	:name => name,
										:email => email,
										:password => password,
										:password_confirmation => password_confirmation )
		end
		# 2012-12-15/11:40
		# User.all[1..6]
		#给前面六个人添加模拟数据
		User.all(:limit => 6).each do |user|
			50.times do 
				user.microposts.create!(:content => Faker::Lorem.sentence(5))
			end
		end
	end
end