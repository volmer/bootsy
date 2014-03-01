Feature: Use a foreign gallery
  In order to select and upload images that don't belong to the item Bootsy is inserted to
  As a writer using Bootsy
  I want to use a foreign gallery

  In these scenarios, all uploaded images in post comments should be
  associated with the post, and the user should be allowed to use
  all images uploaded directly in the post to write comments on it.

  Scenario: access the image gallery of a saved resource
    Given there is a post with images
    And I am on its comment page
    When I press "Insert image"
    Then I see the image gallery
    And the image gallery is not empty

  Scenario: Upload images in the container through another model
    Given there is a post with no images
    And I am on its comment page
    When I press "Insert image"
    And I upload the image "test.jpg"
    And I dismiss the modal
    And I press "Create Comment"
    And I click on "Edit"
    And I access its image gallery
    Then I see the thumbnail "test.jpg" on the image gallery
