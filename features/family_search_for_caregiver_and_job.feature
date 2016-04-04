Feature: Search for Caregiver and Add to Job

Scenario: Search for Caregiver and Add to Job
  Given I am an authenticated User
  And I have a job posting
  And there are caregivers in their zipcode
  And I am on the dashboard page
  When I click "Search Caregivers"
  Then I should see "1 caregivers in Pittsburgh, PA"

  When I click "View Profile"
  And I click "Send Message"
  Then I should see "Job posting"

  And I click "Send"
  Then I should see "Return to Search Page"

  When I click "Add to Job"
  Then I should see "was added to your job."

Scenario: Search for Caregiver and Add to Job and remove from job
  Given I am an authenticated User
  And I have a job posting
  And there are caregivers in their zipcode
  And I am on the dashboard page
  When I click "Search Caregivers"
  Then I should see "1 caregivers in Pittsburgh, PA"

  When I click "View Profile"
  And I click "Send Message"
  Then I should see "Job posting"

  And I click "Send"
  Then I should see "Return to Search Page"

  When I click "Add to Job"
  Then I should see "was added to your job."

  When I click "Manage Job"
  Then I should see "Current Offers"

  When I click "Remove"
  Then I should see "Offer was removed from contract"

Scenario: Search for Caregiver and Add to Job from mangement center
  Given I am an authenticated User
  And I have a job posting
  And there are caregivers in their zipcode
  And I am on the dashboard page
  When I click "Search Caregivers"
  Then I should see "1 caregivers in Pittsburgh, PA"

  When I click "View Profile"
  And I click "Send Message"
  Then I should see "Job posting"

  And I click "Send"
  Then I should see "Return to Search Page"

  When I am on the dashboard page
  And I click "Manage Job"
  Then I should see "Current Offers"

  When I click "Add to Job"
  Then I should see "was added to your job."