Feature: Destroy an image
  In order to clear my gallery
  As a writer using Bootsy
  I want to destroy images

  Background:
    Given I am on the new post page
    And I access its image gallery
    And I upload the image "test.jpg"

  Scenario: destroy an image
    When I click on the image "test.jpg"
    And I click on "Destroy"
    And I accept the alert prompt
    Then I should not see the thumbnail "test.jpg" on the image gallery

  Scenario: cancel the destruction
    When I click on the image "test.jpg"
    And I click on "Destroy"
    And I dismiss the alert prompt
    Then I should see the thumbnail "test.jpg" on the image gallery
