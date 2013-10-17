Feature: Customize editor options
  In order to enable/disable certain functions
  As a developer using Bootsy
  I want to customize the options available for the editor

  Scenario Outline: enable a toolbar option
    When I set "<Config>" to "true" on the editor options of bootsy_area
    And I go to the new post page
    Then I see a link with the option "<Option>" in the editor toolbar
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

  Scenario Outline: disable a toolbar option
    When I set "<Config>" to "false" on the editor options of bootsy_area
    And I go to the new post page
    Then I don't see a link with the option "<Option>" in the editor toolbar
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

  Scenario: disable the alert for unsaved changes
    Given I set "alert-unsaved" to "false" on the editor options of bootsy_area
    And I go to the new post page
    When I change the content of the text area
    And I go to the home page
    Then I should see the home page
