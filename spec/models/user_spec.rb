# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  # 针对 :name 和 :email 属性的测试
  before { @user = User.new(
    name: "Example User", 
    email: "user@example.com",
    password: "123456",
    password_confirmation: "123456"
    ) 
  }
  # before 块会在各测试用例之前执行块中的代码，本例中这个块的作用是为 User.new 传入一个合法的初始 Hash 参数，创建 @user 实例变量。

  subject { @user } # 把 @user 设为这些测试用例默认的测试对象。

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid } # 为了保证测试的全面，确保 @user 对象开始时是合法的

  describe "when name is not present" do
    before { @user.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " "}
    it { should_not be_valid }
  end

  # User长度验证
  describe "when name is too long" do 
    before { @user.name = "a"*51 }
    it { should_not be_valid }
  end

  # Email格式验证
  describe "when email format is invalid" do 
    it "shoule be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do 
    it "shoule be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  #  Email 唯一性验证
  describe "when email address is already taken" do
    before do 
      user_with_same_email = @user.dup
      user_with_same_email.save
    end
    it { should_not be_valid }
  end

  # password 为空
  describe "when password is not present" do
    before {@user.password = @user.password_confirmation = " "}
    it { should_not be_valid }
  end

  # password与password_confirmation 不相同
  describe "when password doesn't match confirmation" do 
    before { @user.password_confirmation = "mismatch" }
  end

  # password_confirmation值为nil
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  # password 密码长度测试
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  # 测试密码是否正确
  describe "return value of authenticate method" do
    before { @user.save } # before 块中的代码先把用户存入数据库，然后在 let 块中调用 find_by_email 方法取出用户
    let(:found_user) { User.find_by_email(@user.email) }
    # 定义了一个名为 found_user 的变量，其值等于 find_by_email 的返回值。
    # 在这个测试用例的任何一个 before 或 it 块中都可以使用这个变量。
    # 不管调用多少次 User 模型测试，find_by_email 方法只会运行一次。

    # 嵌套中的第一个 describe 块通过 let 方法把 find_by_email 的结果赋值给 found_user 之后，在后续的 describe 块中就无需再次查询数据库了。
    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "whtn invalid password" do
      let(:user_for_invalid_password) {found_user.authenticate("invalid")}
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false } 
      # specify 是 it 方法的别名，如果你觉得某个地方用 it 读起来怪怪的，就可以换用 specify。
    end
  end
end
