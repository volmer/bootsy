Feature: Customize editor options
  In order to enable/disable certain functions
  As a developer using Bootsy
  I want to customize the options available in the editor toolbar

  Scenario Outline: enable an editor option
    When I set "<Config>" as "true" on the editor options of bootsy_area
    And I go to the new post page
    Then I should see a link with the option "<Option>" in the editor toolbar
    Examples:
      | Config      | Option         |
      | font_styles | Font style     |
      | color       | Text color     |
      | emphasis    | Bold           |
      | emphasis    | Italic         |
      | emphasis    | Underline      |
      | lists       | Unordered list |
      | lists       | Ordered list   |
      | lists       | Indent         |
      | lists       | Outdent        |
      | link        | Insert link    |
      | image       | Insert image   |
      | html        | Edit HTML      |

  Scenario Outline: disable an editor option
    When I set "<Config>" as "false" on the editor options of bootsy_area
    And I go to the new post page
    Then I should not see a link with the option "<Option>" in the editor toolbar
    Examples:
      | Config      | Option         |
      | font_styles | Font style     |
      | color       | Text color     |
      | emphasis    | Bold           |
      | emphasis    | Italic         |
      | emphasis    | Underline      |
      | lists       | Unordered list |
      | lists       | Ordered list   |
      | lists       | Indent         |
      | lists       | Outdent        |
      | link        | Insert link    |
      | image       | Insert image   |
      | html        | Edit HTML      |