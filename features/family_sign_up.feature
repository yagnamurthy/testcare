Feature: Family Create Account

Scenario: Family creates account through direct link
  Given I am on the become a family page
  And I fill out the family registration form
  And I click "Apply"
  Then I should see "Let's get Started!"

