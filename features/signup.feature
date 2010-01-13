Feature: Signing Up
  Scenario: I am signing up as a user
    Given I am on the home page
      And I follow "sign up"
     When I fill in the following:
        | Username          | mislav                      |
        | First name        | Mislav                      |
        | Last name         | Marohnić                    |
        | Email             | mislav@fuckingawesome.com   |
        | Password          | makeabarrier                |
        | Confirm password  | makeabarrier                |
        And I press "Create account"
      Then I should see "Thank you for signing up"
