Feature: Use a foreign gallery
  In order to select and upload images that don't belong to the item Bootsy is inserted to
  As a writer using Bootsy
  I want to use a foreign gallery

  Scenario: access the image gallery of a saved resource
    Given there is a post with images
    And I am on its comment page
    When I press "Insert image"
    Then I should see the image gallery
    And the image gallery should not be empty