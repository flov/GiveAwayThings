require File.dirname(__FILE__) + '/../spec_helper'

describe Messages do
  it "should be valid" do
    Messages.new.should be_valid
  end
end
