Feature: Caregiver Registration

Scenario: Caregiver Registration
  Given I am an authenticated Caregiver
  And I am on the basics page
  When I fill out the basics with the following data
  	| Date of Birth Month		    | October     |
 	  | Date of Birth Day         | 10          |    
 	  | Date of Birth Year        | 1990        |
 	  | Zipcode                   | 15217       |
 	  | Phone                     | 7174605981  |
    | Gender                    | Male        |
    | Smoking                   | Yes, but not at work |
    | Pets                      | I love pets |
    | Transportation            | Yes, but only on certain days |
    | Allergy                   | Animals     |
    | Language                  | English |
  Then I should see "We want to find you care jobs!"

  When I fill out the about you with the following data
  	| Bio          | Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ullamcorper rutrum turpis, sed placerat ligula facilisis ut. Donec ac sollicitudin neque, tincidunt laoreet arcu. Vestibulum purus sem, posuere ac placerat et, laoreet id neque. Fusce dignissim eros ipsum, quis tempus purus placerat non. Vestibulum eget tortor aliquam, semper justo tincidunt, cursus turpis. Morbi a pharetra augue. Nulla non urna et turpis rutrum tincidunt. Curabitur pulvinar euismod scelerisque. Duis convallis dolor ac risus fermentum, a accumsan.       |
    | Headline     | This is a headline   |
    | Affiliate    | Christ Church Unity  |
  Then I should see "Almost done! Time to let families know when you're available and what services you offer." 

  When I fill out the availability and services with the following data
  	| Provider Type     | Doctor        |
 	| Specialty         | Endocrinology |
 	| Accepts Insurance | Yes           |
 	| ZIP               | 90010         |
 	| Search Radius     | 5 miles       |
  Then I should see "Cut and paste from your resume to save time." 

  When I fill out the education and experiences with the following data
  	| Provider Type     | Doctor        |
 	| Specialty         | Endocrinology |
 	| Accepts Insurance | Yes           |
 	| ZIP               | 90010         |
 	| Search Radius     | 5 miles       |
  Then I should see "Dashboard" 
