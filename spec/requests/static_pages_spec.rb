# rails generate integration_test static_pages
require 'spec_helper'

describe "Static Pages" do

  describe "Home page" do
    it "should have the h1 'Rails Tutorial'" do
      visit '/static_pages/home' #使用了 Capybara 中的 visit 函数来模拟在浏览器中访问 /static_pages/home 的操作。
      page.should have_selector('h1', :text => 'Rails Tutorial') # 使用了 page 变量（同样由 Capybara 提供）来测试页面中是否包含了正确的内容。
    end

    it "should have the base title" do
    	visit '/static_pages/home'
    	page.should have_selector('title', :text => full_title(''))
    	# have_selector 方法会测试一个 HTML 元素（“selector”的意思）是否含有指定的内容。
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      page.should_not have_selector('title', :text => '| Home')
    end
  end

  describe "Help page" do
  	it "should have the h1 'Help'" do
  		visit '/static_pages/help'
  		page.should have_selector('h1', :text => 'Help')
  	end	

  	it "should have the title 'Help'" do
  		visit '/static_pages/help'
  		page.should have_selector('title', :text => full_title('Help'))
  	end
  end

  describe "About page" do
  	it "should have the h1 'About'" do
  		visit '/static_pages/about'
  		page.should have_selector('h1', :text => 'About')
  	end

  	it "should have the title 'About'" do	
  		visit '/static_pages/about'
  		page.should have_selector('title', :text => full_title('About'))
  	end
  end
end
