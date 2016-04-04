Feature: Mailbox Feature

Scenario: Use Mailbox 
  Given I am an authenticated Caregiver
  And I am on the dashboard page
  When I click "header-msg"
  Then I should see "Mailbox"