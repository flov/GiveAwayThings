Feature: Signing Up
  Scenario: I am signing up as a user
    Given I am on the homepage
    And I follow "Sign Up"
    When I fill in the following:
        | Username   | flov                     |
        | Email      | florian.vallen@gmail.com |
        | Password   | makeabarrier             |
        | Confirm it | makeabarrier             |
        | Street     | Darwinstr 50             |
        | City       | Duisburg                 |
    And I select "Germany" from "Country"
    And I press "Sign up"
    Then I should see "Confirm your email!"
    And "florian.vallen@gmail.com" should receive an email
    
