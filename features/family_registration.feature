Feature: Family Registration

Scenario: Family Registration
  Given I am an authenticated User
  And I am on the contract page
  When I fill out the job form with this data
    | Patient Name | Mr. Smith |
    | Headline | This is my care job |
    | Description | This is my description |
    | Hours Needed | 5 to 10 |
    | Zipcode | 15217 |
    | Phone | |
    | Job Type | Hourly |
    | Required Rate | 15.00 |
    | Service Ids | Companionship |
    | Requirement Ids | CNA Preferred |
  And then press submit
  Then I should see "So we can better help you find the right caregivers, please describe your homecare needs."
  When I fill out the job form with this data
    | Patient Name | Mr. Smith |
    | Headline | This is my care job |
    | Description | This is my description |
    | Hours Needed | 5 to 10 |
    | Zipcode | 15217 |
    | Phone | 7174605981 |
    | Job Type | Hourly |
    | Required Rate | 15.00 |
    | Service Ids | Companionship |
    | Requirement Ids | CNA Preferred |
  And then press submit
  Then I should see "Please select the local organizations you and/or your loved one belong to, and "

  When I fill out the shared_connections form with this data
    | Affiliate Ids       | Christ Church Unity  |
  Then I should see "Dashboard"
