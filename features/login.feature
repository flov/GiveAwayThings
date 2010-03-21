Feature: Logging In
  Background:
    Given I am currently "flov"
      And I go to the login page
      And I fill in "Email or Username" with "flov"
      And I fill in "Password" with "makeabarrier"
      And I press "Login"

    
  Scenario: Flov successfully logs in with a confirmed email
    When I have confirmed my email
    And I go to the home page    
    Then I should see "All Projects"
    
  Scenario: Flov fails to log in because he did not confirm his email
    When I have never confirmed my email
     And I go to the home page    
    Then I should see "Confirm your email"

  Scenario: Flov logs in for the first time and sees the welcome tab (he is not impressed)
    When  I have confirmed my email
    And It is my first time logging in
    When I go to the home page
    Then I should see "Welcome"
