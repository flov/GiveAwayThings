Feature: Signing Up
  Scenario: I am signing up as a user
    Given I am on the homepage
    And I follow "Sign Up"
    When I fill in the following:
        | Username   | flov                     |
        | Email      | florian.vallen@gmail.com |
        | Password   | makeabarrier             |
        | Confirm it | makeabarrier             |
        | Country    | makeabarrier             |
        | City       | Duisburg                 |
        | Street     | Darwinstr 50             |

    And I press "Sign up"
    Then I should see "Thank you for signing up"
