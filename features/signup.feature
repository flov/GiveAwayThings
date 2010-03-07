Feature: Signing Up
  Scenario: I am signing up as a user
    Given I am on the homepage
    And I follow "Sign Up"
    When I fill in the following:
        | Username              | flov                     |
        | Email                 | florian.vallen@gmail.com |
        | Country               | Germany                  |
        | Password              | makeabarrier             |
        | Password confirmation | makeabarrier             |
    And I press "Sign up"
    Then I should see "Thank you for signing up"
