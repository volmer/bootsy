Feature: Delete an image
  In order to clear my gallery
  As a writer using Bootsy
  I want to delete images

  Background:
    Given I am on the new post page
    And I access its image gallery
    And I upload the image "test.jpg"

  Scenario: delete an image
    When I click on the image "test.jpg"
    And I click on "Delete"
    And I accept the alert prompt
    Then I don't see the thumbnail "test.jpg" on the image gallery
    And I see the message "There are currently no uploaded images."

  Scenario: cancel the deletion
    When I click on the image "test.jpg"
    And I click on "Delete"
    And I dismiss the alert prompt
    Then I see the thumbnail "test.jpg" on the image gallery
