Feature: Upload an image
  In order to illustrate my texts
  As a writer using Bootsy
  I want to upload images

  Background:
    Given I am on the new post page
    And I access its image gallery

  Scenario: upload a valid image
    When I attach the file "test.jpg" on "image_file"
    And I press "Load"
    Then I should see the thumbnail "test.jpg" on the image gallery