Feature: Two bootsy inputs on one page
  In order to use Bootsy
  On two inputs on the same page

  Background:
    Given I am on the new post page

  Scenario: Upload an image in first input
    When I access its image gallery within field post_content
    And I attach the file "test.jpg" on "image_file"
    And I access its image gallery within field comment_content
    Then I should see the thumbnail "test.jpg" on the image gallery

  Scenario: Delete an image in first input
    When I access its image gallery within field post_content
    And I attach the file "test.jpg" on "image_file"
    And I click on the image "test.jpg"
    And I click on "Delete"
    And I accept the alert prompt
    And I access its image gallery within field comment_content
    Then I should not see the thumbnail "test.jpg" on the image gallery
