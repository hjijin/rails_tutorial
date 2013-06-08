require 'spec_helper'

describe "User Pages" do

	subject { page }
	
  # 用户列表页面的测试
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1', text: 'All users') }
    
    # 测试分页功能
    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.name)
        end
      end
    end

    # 测试删除用户功能
    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe "signup page" do

    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end

  describe "profile page" do

  	let(:user) { FactoryGirl.create(:user) } # Code to make a user variable
  	before { visit user_path(user) }

  	it { should have_selector('h1', text: user.name) }
  	it { should have_selector('title', text: user.name) }
  end

  describe "signup" do
  	before { visit signup_path }
  	let(:submit) { "Create my account" }

  	describe "with invalid information" do
  		it "should not create a user" do
  			expect { click_button submit }.not_to change(User, :count)
  		end

      # 错误提示信息测试
      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Sign up') }
        it { should have_content('error') }
      end
  	end

  	describe "with valid information" do
  		before do 
  			fill_in "Name", with: "Example User"
  			fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
  		end

  		it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      # 对 create 动作中保存用户操作的测试
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out') } # 测试刚注册的用户是否会自动登录
      end
  	end
  end

  # 用户编辑页面的测试
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user # 为 edit 和 update 测试加入登录所需的代码
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1', text: "Update your profile") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }
      it { should have_content('error') }
    end

    # 测试 Users 控制器的 update 动作
    # describe "with valid information" do
    #   let(:new_name) { "New Name" }
    #   let(:new_email) { "new@example.com" }
    #   before do
    #     fill_in "Name",             with: new_name
    #     fill_in "Email",            with: new_email
    #     fill_in "Password",         with: user.password
    #     fill_in "Confirm Password", with: user.password
    #     click_button "Save changes"
    #   end

    #   it { should have_selector('title', text: new_name) }
    #   it { should have_selector('div.alert.alert-success') }
    #   it { should have_link('Sign out', href: signout_path) }
    #   specify { user.reload.name.should == new_name } 
    #   # 使用 user.reload 从测试数据库中重新加载 user 的数据，然后检测用户的名字和 Email 地址是否更新成了新的值。
    #   specify { user.reload.email.should == new_email }
    # end
  end
end
