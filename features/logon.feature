Feature: Users logon
  In order to access the system
  As a user
  I want to be able to logon
  
  Scenario Outline: Logon Failure
    Given I am on the logon page
    And the following users are registered
      | email               | password | name          |
      | test@company.com    | secret   | Test User     |
      | admin@ninjafund.com | password | Administrator |
    When I try and login with "<login>" and password "<password>"
    And I press Logon
    Then I should <action>
    
    Examples:
      | login               | password  | action                           |
      | test@company.com    | secret    | see my Dashboard                 |      
      | admin@ninjafund.com | incorrect | see the Logon Page with an error |
      | not@registered.com  | password  | see the Logon Page with an error |
      
  Scenario Outline: Logon Excellence
    Given I am on the logon page
    And no one is registered
    When I try and login with "user@ninjafund.com" and password "password"
    And I press Logon
    Then I should see the Logon Page with an error
