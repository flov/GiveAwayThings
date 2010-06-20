require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  describe "finding an available username" do
    it "should return the proposed one if it's free" do
      User.find_available_login("donnie").should == "donnie"
    end

    it "should propose a new one if it's taken" do
      Factory(:user, :login => "rabbit")
      User.find_available_login("rabbit").should == "rabbit2"
    end

    it "should keep looking for a free one until it's possible" do
      Factory(:user, :login => "timetravel")
      Factory(:user, :login => "timetravel2")
      Factory(:user, :login => "timetravel3")
      User.find_available_login("timetravel").should == "timetravel4"
    end

    it "should not take a deleted user's login" do
      that_girl = Factory(:user, :login => "the_girl_who_dies").destroy
      User.find_available_login(that_girl.login).should == "#{that_girl.login}2"
    end
  end
end
