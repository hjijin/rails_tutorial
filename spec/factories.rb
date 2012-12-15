Factory.define :user do |user|
	user.name										"Michael Hartl"
	user.email									"mhartl@example.com" 
	user.password 							"foobar"
	user.password_confirmation 	"foobar"
end
# 2012-12-14/10:00
Factory.sequence :email do |n|
	"person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end