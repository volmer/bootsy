Feature: Simple Form integration
  In order to use Bootsy
  As a developer using Simple Form
  I want to be able to have the Bootsy editor fully integrated with the Simple Form's wrappers

  Scenario: Upload an image in a Simple Form
    Given I am on the new simple form post page
    And I access its image gallery
    When I attach the file "test.jpg" on "image_file"
    Then I should see the thumbnail "test.jpg" on the image gallery
