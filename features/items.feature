Feature: Create Item
  Background:
    Given I am logged in as "flov"
    
  Scenario: 

  
  Scenario: Items List
    Given I have items titled Books, TV
    When I go to the list of items 
    Then I should see "Books"
    And  I should see "TV"


