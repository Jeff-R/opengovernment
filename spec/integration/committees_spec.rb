# require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'spec_helper'
require 'capybara/rspec'
# require 'webrat/integrations/rspec-rails'

describe "Committees Page" do
  before do
    # @request.host = "tx.example.org"
    # Capybara.default_host = "tx.example.com"
    # Capybara.app_host = "http://tx.example.com:9887" if Capybara.current_driver == :culerity

    Capybara.configure do |c|
      c.app_host = "http://tx.example.com"
    end

  end

  it "should show the list of committees" do

    visit "/"
    show_filtered_links "Texas"
    click_on "Texas"

    show_filtered_links "People"
    click_on "People"

    show_filtered_links "Senate Committees"
    click_on "Senate Committees"

    show_page_links

    # Capybara.configure do |c|
    #   c.app_host = "http://tx.example.com"
    # end

    # page.should have_content "Members"
  end

  def click_on text
    puts
    puts "Clicking on '#{text}'"
    click_link text
  end

  def show_page_links
    links = page.all(:css, 'a')
    puts
    puts "show_page_links:"
    puts "url: #{page.current_url.to_s}"
    links.each do |link|
      if link.text =~ /Committees/
        puts "  #{link.text.to_s} : #{link['href'].to_s}"
      end
    end
  end

  def show_filtered_links text
    links = page.all(:css, 'a')
    puts
    puts "show_page_links:"
    puts "url: #{page.current_url.to_s}"
    links.each do |link|
      if link.text =~ /#{text}/
        puts "  #{link.text.to_s} : #{link['href'].to_s}"
      end
    end
  end

  # http://asciicasts.com/episodes/187-testing-exceptions
  def filtered_backtrace
    if exception = @response.template.instance_variable_get(:@exception)
      filter_backtrace(exception.backtrace).join("\n")

      # If you want indentation you can use this
      #
      # filter_backtrace(exception.backtrace).collect { |line| "  #{line}" }.join("\n")
      #
      # You can't add the indenting part as a filter (with Rails.backtrace_cleaner.add_filter
      # in config/initializers/backtrace_silencers.rb) because it breaks existing filters and silencers
    end
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

