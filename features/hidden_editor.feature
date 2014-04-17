Feature: Load a hidden editor
  In order to toggle the visibility of my editor
  As a developer using Bootsy
  I want to be able to load the editor in a hidden state

  To ensure this feature there is the ability to
  edit comments in the dummy app. To edit comments the
  user needs to click on the "edit" link, and then
  a hidden editor becomes visible.

  It is important to ensure this feature due to some
  issues with Firefox and hidden elements.

  Scenario: Update a comment
    Given there is a post with a comment
    And I am on its comment page
    When I click on "Edit comment"
    And I fill in the "comment_content" editor with "Edited content"
    And I press "Update Comment"
    Then I see "Comment was successfully updated" on the page
    And I see "Edited content" on the page
