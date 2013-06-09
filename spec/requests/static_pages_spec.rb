# rails generate integration_test static_pages
require 'spec_helper'

describe "Static Pages" do
  # 用例都引用了 page 变量。我们可以告诉 RSpec，page 就是要测试的对象（subject），这样就可以避免多次使用 page：
  subject { page }

  describe "Home page" do
    # 三个测试用例都访问了根地址，使用 before 块可以消除这个重复：
    before { visit root_path }
    # 在每个测试用例运行之前访问根地址。（before 方法还可以使用别名 before(:each) 调用。）

    # 然后再使用 it 方法的另一种形式，把测试代码和描述文本合二为一：
    it { should have_selector('h1', text: 'Rails Tutorial') }
    # 因为指明了 subject { page }，所以调用 should 时就会自动使用 Capybara 提供的 page 变量

    # it "should have the h1 'Rails Tutorial'" do
      # visit '/static_pages/home' #使用了 Capybara 中的 visit 函数来模拟在浏览器中访问 /static_pages/home 的操作。
      # visit home_path
      # page.should have_selector('h1', :text => 'Rails Tutorial') # 使用了 page 变量（同样由 Capybara 提供）来测试页面中是否包含了正确的内容。
    # end

    # it { should have_selector 'title', text: "Rails Tutorial" }
    # 简化后：
    it { should have_selector('title', text: full_title('')) }
    # it "should have the title 'Home'" do
    	# visit '/static_pages/home'
      # visit home_path
    	# page.should have_selector('title', :text => "Rails Tutorial")
    	# have_selector 方法会测试一个 HTML 元素（“selector”的意思）是否含有指定的内容。
    # end

    it { should_not have_selector 'title', text: '| Home' }
    # it "should not have a custom page title" do
    #   page.should_not have_selector('title', text: '| Home')
    # end

    # 测试首页中显示的关注和粉丝数量统计
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem")
        FactoryGirl.create(:micropost, user: user, content: "Ipsum")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end
    end
  end

  describe "Help page" do
    
    before { visit help_path }

    it { should have_selector('h1',    text: 'Help') }
  	# it "should have the h1 'Help'" do
  		# visit '/static_pages/help'
      # visit help_path
  		# page.should have_selector('h1', :text => 'Help')
  	# end	

    it { should have_selector('title', text: full_title('Help')) }
  	# it "should have the title 'Help'" do
  		# visit '/static_pages/help'
      # visit help_path
  		# page.should have_selector('title', :text => "Rails Tutorial | Help")
  	# end
  end

  describe "About page" do

    before { visit about_path }

    it { should have_selector('h1',    text: 'About') }
  	# it "should have the h1 'About'" do
  		# visit '/static_pages/about'
      # visit about_path
  		# page.should have_selector('h1', :text => 'About')
  	# end

    it { should have_selector('title', text: full_title('About')) }
  	# it "should have the title 'About'" do	
  		# visit '/static_pages/about'
      # visit about_path
  		# page.should have_selector('title', :text => "Rails Tutorial | About")
  	# end
  end

  describe "Contact page" do

    before { visit contact_path }

    it { should have_selector('h1',    text: 'Contact') }
    # it "should have the h1 'Contact'" do
      # visit '/static_pages/contact'
      # visit contact_path
      # page.should have_selector('h1', text: 'Contact')
    # end

    it { should have_selector('title', text: full_title('Contact')) }
    # it "should have the title 'Contact'" do 
      # visit '/static_pages/contact'
      # visit contact_path
      # page.should have_selector('titel', text: "Rails Tutorial | Contact")
    # end
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About')
    click_link "Help"
    page.should # fill in
    click_link "Contact"
    page.should # fill in
    click_link "Home"
    click_link "Sign up now!"
    page.should # fill in
    click_link "Tutorial"
    page.should # fill in
  end

  # 测试首页显示的微博列表
  describe "for signed-in users" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
      FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
      sign_in user
      visit root_path
    end

    it "should render the user's feed" do
      user.feed.each do |item|
        page.should have_selector("li##{item.id}", text: item.content)
        # li##{item.id} 中的第一个 # 是 Capybara 中的对应 CSS id 的句法，而第二个 # 则代表 Ruby 字符串插值操作 #{} 的开始。
      end
    end
  end
end
