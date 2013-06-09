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
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:microposts) } # 测试用户对象是否可以响应 microposts 方法
  it { should respond_to(:feed) } # 对临时动态列表的测试
  it { should respond_to(:relationships) } # 测试 user.relationships
  it { should respond_to(:followed_users) } # 测试 user.followed_users 属性
  it { should respond_to(:following?) }
  it { should respond_to(:follow!) }
  it { should respond_to(:unfollow!) } # 测试取消关注用户
  it { should respond_to(:reverse_relationships) }
  it { should respond_to(:followers) }

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

    describe "with invalid password" do
      let(:user_for_invalid_password) {found_user.authenticate("invalid")}
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false } 
      # specify 是 it 方法的别名，如果你觉得某个地方用 it 读起来怪怪的，就可以换用 specify。
    end
  end

  # 把 Email 地址转换成小写字母形式
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end
  # 测试合法的（非空）remember_token
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank } # == it { @user.remember_token.should_not be_blank }
  end

  # 测试 admin 属性
  it { should respond_to(:admin) }
  it { should respond_to(:authenticate) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before { @user.toggle!(:admin) } # 使用 toggle! 方法把 admin 属性的值从 false 转变成 true。

    it { should be_admin } # 说明用户对象应该可以响应 admin? 方法
  end

  # 测试用户微博的次序
  describe "micropost associations" do
    before { @user.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right microposts in the right order" do
      @user.microposts.should == [newer_micropost, older_micropost]
    end

    it "should destroy associated microposts" do
      microposts = @user.microposts.dup
      @user.destroy
      microposts.should_not be_empty
      microposts.each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end

    # 对临时动态列表的测试
    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
      end
      let(:followed_user) { FactoryGirl.create(:user) }

      before do
        @user.follow!(followed_user)
        3.times { followed_user.microposts.create!(content: "Lorem ipsum") }
      end

      its(:feed) { should include(newer_micropost) }
      its(:feed) { should include(older_micropost) }
      its(:feed) { should_not include(unfollowed_post) }
      its(:feed) do
        followed_user.microposts.each do |micropost|
          should include(micropost)
        end
      end
    end
  end

  # 测试关注关系用到的方法
  describe "following" do
    let(:other_user) { FactoryGirl.create(:user) }
    before do
      @user.save
      @user.follow!(other_user)
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) } 

    describe "and unfollowing" do
      before { @user.unfollow!(other_user) }
      it { should_not be_following(other_user) }
      its(:followed_users) { should_not include(other_user) }
    end

    it { should be_following(other_user) }
    its(:followed_users) { should include(other_user) }

    describe "followed user" do
      subject { other_user }
      its(:followers) { should include(@user) }
    end
  end
end
