Feature: Bootsy in nested attributes
  In order to use Bootsy
  As a developer creating forms with nested attributes
  I want to be able to add a bootsy area in a nested attribute

  Scenario: Use Bootsy in nested attributes
    Given I am on the root page
    When I click on "New post with comment"
    And I fill in "Title" with "My post"
    And I fill in the "post_content" editor with "My content"
    And I fill in "Author" with "Comment author"
    And I fill in the "post_comments_attributes_0_content" editor with "My comment"
    And I press "Create Post"
    Then I see "My post" on the page
    And I see "My content" on the page
    And I see "Comment author" on the page
    And I see "My comment" on the page
