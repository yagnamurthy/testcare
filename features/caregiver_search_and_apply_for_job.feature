Feature: Search for Job and Add to Job

Scenario: Search and Apply for Job as a caregiver
  Given I am an fully registered and authenticated Caregiver
  And I am on the dashboard page
  And there are jobs to apply to
  When I click "Search Jobs"
  Then I should see "Care Jobs near"

  When I click "Apply"
  And I fill out the message form
  And I click "Apply"
  Then I should see "Dashboard"
  And I click "View Offers"
  And I click "Read More"
  Then I should see "Job Posting"

  When I click "Decline"
  Then I should see "Dashboard"