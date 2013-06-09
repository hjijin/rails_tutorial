# namespace :db do
#   desc "Fill database with sample data"
#   # 定义了一个名为 db:populate 的 Rake 任务
#   task populate: :environment do
#     # 面这行代码确保这个 Rake 任务可以获取 Rails 环境的信息，包括 User 模型
#     admin = User.create!(name: "Example User",
#                  email: "example@railstutorial.org",
#                  password: "foobar",
#                  password_confirmation: "foobar")
#     admin.toggle!(:admin)

#     99.times do |n|
#       name = Faker::Name.name
#       email = "example-#{n+1}@railstutorial.org"
#       password = "password"
#       User.create!(name: name,
#                    email: email,
#                    password: password,
#                    password_confirmation: password)
#     end

#     users = User.all(limit: 6)
#     50.times do
#       content = Faker::Lorem.sentence(5)
#       users.each { |user| user.microposts.create!(content: content) }
#     end
#   end
# end

# 这个任务是定义在 :db 命名空间中的，所以我们要按照如下的方式来执行：
  # $ rake db:reset
  # $ rake db:populate
  # $ rake db:test:prepare
# 执行这三个任务之后，我们的应用程序就有 100 个用户了

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  admin = User.create!(name: "Example User",
               email: "example@railstutorial.org",
               password: "foobar",
               password_confirmation: "foobar")
  admin.toggle!(:admin)

  50.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  30.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end