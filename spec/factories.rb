# FactoryGirl.define do
#   # 定义了一个 User 模型对象
#   factory :user do
#     name     "jijin"
#     email    "jijin@gmail.com"
#     password "123456"
#     password_confirmation "123456"
#   end
# end

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    factory :admin do
      admin true
    end
  end
end