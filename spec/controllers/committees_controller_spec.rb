require 'spec_helper'

describe CommitteesController do
  # render_views

  describe "GET index" do 
    before :each do
      @request.host = "tx.example.com"
      @texas = Factory.build(:state, :name => "Texas")
    #   @education  = Factory.build(:committee, :name => "Education")
    #   @committee1 = Factory.build(:committee)
    #   @committee2 = Factory.build(:committee)
    end

    describe "index" do
      it "should show the index" do
        State.stub(:find_by_slug).and_return(@texas)
        get :index
        response.should render_template "committees/index"
        #puts "parts: #{response.to_yaml.inspect}"
        puts "body: #{response.inspect}"
      end
    end

  end
end

