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

  Scenario: Upload a valid image from a URL
    When I fill in "image[remote_image_file_url]" with "http://stubhost.com/test.jpg"
    And I press "Go"
    Then I see the thumbnail "test.jpg" on the image gallery

  Scenario: Upload an invaild image
    When I attach the file "test.fake" on "image_file"
    Then I don't see the thumbnail "test.jpg" on the image gallery
    Then I see "You are not allowed to upload" on the page
    When I press "Refresh"
    Then I don't see "You are not allowed to upload" on the page

  Scenario: Associate the uploaded image with the container
    When I upload the image "test.jpg"
    And I insert the image "test.jpg" on the text
    And I fill in "Title" with "Awesome post"
    And I press "Create Post"
    And I click on "Edit"
    And I access its image gallery
    Then I see the thumbnail "test.jpg" on the image gallery
