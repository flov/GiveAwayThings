Feature: Create Item
  In order to post an item
  As a person
  I want to create and manage items
  
  Scenario: Items List
    Given I have items titled Books, TV
    When I go to the list of items 
    Then I should see "Books"
    And  I should see "TV"
