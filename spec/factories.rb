FactoryGirl.define do
  # 定义了一个 User 模型对象
  factory :user do
    name     "jijin"
    email    "jijin@gmail.com"
    password "123456"
    password_confirmation "123456"
  end
end