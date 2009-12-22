require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def new_person(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    person = Person.new(attributes)
    person.valid? # run validations
    person
  end
  
  def setup
    Person.delete_all
  end
  
  def test_valid
    assert new_person.valid?
  end
  
  def test_require_username
    assert new_person(:username => '').errors.on(:username)
  end
  
  def test_require_password
    assert new_person(:password => '').errors.on(:password)
  end
  
  def test_require_well_formed_email
    assert new_person(:email => 'foo@bar@example.com').errors.on(:email)
  end
  
  def test_validate_uniqueness_of_email
    new_person(:email => 'bar@example.com').save!
    assert new_person(:email => 'bar@example.com').errors.on(:email)
  end
  
  def test_validate_uniqueness_of_username
    new_person(:username => 'uniquename').save!
    assert new_person(:username => 'uniquename').errors.on(:username)
  end
  
  def test_validate_odd_characters_in_username
    assert new_person(:username => 'odd ^&(@)').errors.on(:username)
  end
  
  def test_validate_password_length
    assert new_person(:password => 'bad').errors.on(:password)
  end
  
  def test_require_matching_password_confirmation
    assert new_person(:password_confirmation => 'nonmatching').errors.on(:password)
  end
  
  def test_generate_password_hash_and_salt_on_create
    person = new_person
    person.save!
    assert person.password_hash
    assert person.password_salt
  end
  
  def test_authenticate_by_username
    Person.delete_all
    person = new_person(:username => 'foobar', :password => 'secret')
    person.save!
    assert_equal person, Person.authenticate('foobar', 'secret')
  end
  
  def test_authenticate_by_email
    Person.delete_all
    person = new_person(:email => 'foo@bar.com', :password => 'secret')
    person.save!
    assert_equal person, Person.authenticate('foo@bar.com', 'secret')
  end
  
  def test_authenticate_bad_username
    assert_nil Person.authenticate('nonexisting', 'secret')
  end
  
  def test_authenticate_bad_password
    Person.delete_all
    new_person(:username => 'foobar', :password => 'secret').save!
    assert_nil Person.authenticate('foobar', 'badpassword')
  end
end
