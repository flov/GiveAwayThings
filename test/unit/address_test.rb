require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  def test_valid
    Factory(:address)
  end
  
  def test_should_not_save_without_street
    address = Address.new
    assert !address.save
  end
  
  def test_should_not_save_without_country
    address=Factory.build(:address)
    address.country_id = nil
    assert !address.valid?
  end

  def test_should_not_save_without_city
    address=Factory.build(:address)
    address.city_id = nil
    assert !address.valid?
  end
end
