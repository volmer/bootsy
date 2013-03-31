Feature: Customize buttons
  In order to enable/disable certain functions
  As a developer using Bootsy
  I want to customize the buttons available in the editor toolbar

  Scenario Outline: insert an image with a specific size
    When I set "<Option>" as "false" on the editor options of bootsy_area
    And I go to the new post page
    Then I should see the button titled "<Button>"
    Examples:
      | Option      | Button       |
      | font_styles | Font styles  |
      | emphasis    | Emphasis     |
      | lists       | Lists        |
      | html        | HTML         |
      | image       | Insert Image |
      | color       | Color        |