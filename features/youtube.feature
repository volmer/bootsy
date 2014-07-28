Feature: Insert YouTube video
  In order to have videos in my content
  As a writer using Bootsy
  I want to insert YouTube embedded videos

  Scenario: Insert YouTube code
    Given I am on the new post page
    When I paste an YouTube video markup
    Then I see the video iframe properly rendered
