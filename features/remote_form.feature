Feature: Use Bootsy with a remote form
  In order to avoid a page reload
  As a developer
  I want to be able to use a Bootsy input with a remote form

  Scenario: Insert a content and submit a post
    Given I am on the posts page
    And I press "New remote post"
    And I fill in "Title" with "Awesome post"
    And I access its image gallery
    When I attach the file "test.jpg" on "image_file"
    And I insert the image "test.jpg" on the text
    And I press "Create Post"
    Then I see the post created with the image "test.jpg" in it
