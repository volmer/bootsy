Feature: Insert an image
  In order to illustrate my text
  As a writer using Bootsy
  I want to insert images on it

  Background:
    Given I am on the new post page
    And I access its image gallery
    And I upload the image "test.jpg"

  Scenario Outline: insert an image with a specific size
    When click on the image "test.jpg"
    And I click on "<Size>"
    Then I should see the image "test.jpg" in its <Size> size inserted on the text area
    Examples:
      | Size     |
      | Small    |
      | Medium   |
      | Large    |
      | Original |