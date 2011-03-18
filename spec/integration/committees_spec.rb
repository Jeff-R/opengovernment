# require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
# require 'spec_helper'
require 'capybara/rspec'

describe "Committees Page" do
  before do
    Capybara.default_host = "tx.example.com"
    Capybara.app_host = "http://tx.example.com:9887" if Capybara.current_driver == :culerity

  end

  it "should show the list of committees" do
    Capybara.default_host = "tx.example.com"
    visit root_url
    status_file "/home/jeff/page_root.html", page

    click_link "Texas"
    status_file "/home/jeff/page_texas.html", page

    page.should have_content('Texas')
    page.should have_content('People')

    click_link "People"

    status_file "/home/jeff/page_people.html", page
    # File.open("/home/jeff/page.html", "w+") { |f| f.puts current_url }
    # File.open("/home/jeff/page.html", "a") { |f| f.puts page.source }

    page.should have_content('Committees')

    click_link "Senate Committees"

    status_file "/home/jeff/page_committees.html", page
    # File.open("/home/jeff/page2.html", "w+") { |f| f.puts current_url }
    # File.open("/home/jeff/page2.html", "a") { |f| f.puts page.source }

    # puts "current_url: #{page.current_url}"
    page.should have_content('Texas Senate Committees')
  end

  def status_file filename, page
    File.open(filename, "w+") { |f| f.puts page.current_url }
    File.open(filename, "a") { |f| f.puts page.source }
  end

  def show_methods obj
    obj.methods.each do |method|
      puts obj.method(method).to_s
    end
  end
end

