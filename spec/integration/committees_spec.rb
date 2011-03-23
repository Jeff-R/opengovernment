# require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'spec_helper'

describe "Capybara with a subdomain" do
  before :each do
    @leg = Factory.create(:legislature)
    @committees = []
    @committees << Factory.create(:committee, :legislature => @leg)
    @committees << Factory.create(:committee, :legislature => @leg)
  end

  it "should visit a page correctly using a default_host" do
    Capybara.default_host = "md.www.example.com"
    visit upper_committees_path

    page.should have_content "Maryland Committees"
  end

  it "should navigate to a page by clicks without a default_host" do
    pending "We need to fill out the factories with some bills."
    visit "/"
    click_on "Maryland"
    click_on "People"
    click_on "Committees"

    page.should have_content "Maryland Committees"
  end

end

describe "Factories" do
  before :each do
    Capybara.default_host = "md.www.example.com"
    @md  = Factory.create(:state)
    @leg = Factory.create(:legislature, :state => @md)
    @committees = []
    @committees << Factory.create(:committee, :legislature => @leg)
    @committees << Factory.create(:committee, :legislature => @leg)
    @committees << Factory.build(:committee, :legislature => @leg)
  end

  it "should make Maryland committees" do
    # @leg = Factory.create(:legislature, :name => "Maryland")
    # @leg = Factory.create(:legislature)
    # puts "state is #{@leg.state.name}"


    @committees << Factory.create(:committee, :legislature => @leg)
    @committees << Factory.create(:committee, :legislature => @leg)
    @committees << Factory.create(:committee, :legislature => @leg)
    @committees << Factory.create(:committee, :legislature => @leg)
    @committees << Factory.create(:committee, :legislature => @leg)

    # puts "@leg = #{@leg.inspect}"
    # committees.each do |c|
    #   puts "committee: #{c.inspect}"
    # end

    puts "------------------------------"
    puts "Visiting upper_committees_path"
    puts ""
    visit committees_url
    visit upper_committees_path
    # puts page.body

    page.should have_content "Maryland Committees"
  end

  # it "should have all the states, from fixtures, already" do

  #   State.all.each do |state|
  #     puts "state: #{state.inspect}"
  #   end
  # end

end

describe "Committees Page" do
  before do
    Capybara.default_host = "md.www.example.com"
    @leg = Factory.create(:legislature)
    @committees = []
    @committees << Factory.create(:committee, :legislature => @leg)
    @committees << Factory.create(:committee, :legislature => @leg)
  end

  
  it "should show the list of committees" do

    visit upper_committees_path
    page.should have_content "Maryland Committees"

    click_on "Joint Committees"
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
      puts "  #{link.text.to_s} : #{link['href'].to_s}"
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

