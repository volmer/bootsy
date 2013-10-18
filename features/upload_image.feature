Feature: Upload an image
  In order to illustrate my texts
  As a writer using Bootsy
  I want to upload images

  Background:
    Given I am on the new post page
    And I access its image gallery

  Scenario: Upload a valid image
    When I attach the file "test.jpg" on "image_file"
    Then I see the thumbnail "test.jpg" on the image gallery

  Scenario: Associate the uploaded image with the container
    When I upload the image "test.jpg"
    And I insert the image "test.jpg" on the text
    And I fill in "Title" with "Awesome post"
    And I press "Create Post"
    And I click on "Edit"
    And I access its image gallery
    Then I see the thumbnail "test.jpg" on the image gallery
