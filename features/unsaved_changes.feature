Feature: Unsaved changes
  In order to do not lose my content not saved yet
  As a writer using Bootsy
  I want to be notified for unsaved changes when I close the window

  Background:
    Given I am on the new post page
    And I change the content of the text area

  Scenario: leave window
    When I go to the home page
    And I accept the alert prompt
    Then I see the home page

  Scenario: stay on window
    When I go to the home page
    And I dismiss the alert prompt
    Then I see the new post page
