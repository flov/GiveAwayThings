Feature: Make a Request
  Background:
    Given I am logged in as "florian"
    And I am on the inbox page
  
  Scenario: Items List
    Given I have items titled Books, TV
    When I go to the list of items 
    Then I should see "Books"
    And  I should see "TV"