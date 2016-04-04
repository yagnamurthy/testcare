Feature: User (Family, Caregiver, or Other) creates a reference


Scenario: Guest User creates a reference
  Given a caregiver is created
  And I am on the caregiver profile page

  When I fill out the reference form correctly
  And I click "Create reference"
  Then I should see "This is a sample reference"

Scenario: Family creates a reference
  Given I am an authenticated User
  And a caregiver is created
  And I am on the caregiver profile page

  When I fill out the reference form incorrectly
  And I click "Create reference"
  When I fill out the reference form correctly
  And I click "Create reference"
  Then I should see "This is a sample reference"

Scenario: Caregiver creates a reference
  Given I am an authenticated Caregiver
  And a caregiver is created
  And I am on the caregiver profile page

  When I fill out the reference form correctly
  And I click "Create reference"
  Then I should see "This is a sample reference"