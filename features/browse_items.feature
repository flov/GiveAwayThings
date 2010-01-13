Feature: Browse Items

  So that I can quickly find items of interest
  As a user
  I want to browse items by categories
  
  Scenario: Add item to category
    Given a category named Toy
    When I create an item Teddy in the Toy category
    Then Teddy should be in the Toy category