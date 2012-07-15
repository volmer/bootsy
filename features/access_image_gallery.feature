Feature: Access the image gallery
  In order to select and upload images
  As a writer using Bootsy
  I want to access the image gallery

  Scenario: access the image gallery of a new resource
    Given I am on the new post page
    When I press "Insert image"
    Then I should see the image gallery
    And the image gallery should be empty

  Scenario: access the image gallery of a saved resource
    Given there is a post with images
    And I am on its edit page
    When I press "Insert image"
    Then I should see the image gallery
    And the image gallery should not be empty