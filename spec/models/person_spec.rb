require File.dirname(__FILE__) + '/../spec_helper'

describe Person do
  def new_person(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    Person.new(attributes)
  end
  
  before(:each) do
    Person.delete_all
  end
  
  it "should be valid" do
    new_person.should be_valid
  end
  
  it "should require username" do
    new_person(:username => '').should have(1).error_on(:username)
  end
  
  it "should require password" do
    new_person(:password => '').should have(1).error_on(:password)
  end
  
  it "should require well formed email" do
    new_person(:email => 'foo@bar@example.com').should have(1).error_on(:email)
  end
  
  it "should validate uniqueness of email" do
    new_person(:email => 'bar@example.com').save!
    new_person(:email => 'bar@example.com').should have(1).error_on(:email)
  end
  
  it "should validate uniqueness of username" do
    new_person(:username => 'uniquename').save!
    new_person(:username => 'uniquename').should have(1).error_on(:username)
  end
  
  it "should not allow odd characters in username" do
    new_person(:username => 'odd ^&(@)').should have(1).error_on(:username)
  end
  
  it "should validate password is longer than 3 characters" do
    new_person(:password => 'bad').should have(1).error_on(:password)
  end
  
  it "should require matching password confirmation" do
    new_person(:password_confirmation => 'nonmatching').should have(1).error_on(:password)
  end
  
  it "should generate password hash and salt on create" do
    person = new_person
    person.save!
    person.password_hash.should_not be_nil
    person.password_salt.should_not be_nil
  end
  
  it "should authenticate by username" do
    person = new_person(:username => 'foobar', :password => 'secret')
    person.save!
    Person.authenticate('foobar', 'secret').should == person
  end
  
  it "should authenticate by email" do
    person = new_person(:email => 'foo@bar.com', :password => 'secret')
    person.save!
    Person.authenticate('foo@bar.com', 'secret').should == person
  end
  
  it "should not authenticate bad username" do
    Person.authenticate('nonexisting', 'secret').should be_nil
  end
  
  it "should not authenticate bad password" do
    new_person(:username => 'foobar', :password => 'secret').save!
    Person.authenticate('foobar', 'badpassword').should be_nil
  end
end
