Given(/^I am on the (.*?) page$/) do |page|
  case page 
  when 'basics'
  	visit basics_path
  when 'contract'
  	visit family_job_path
  when 'dashboard'
  	visit dashboard_path
  when 'become a family' 
  	visit web_become_a_family_path
  when 'caregiver profile'
    caregiver = Caregiver.last
    visit caregiver_path(caregiver, rf: caregiver.md5hash)
  end
end

When(/^I click "(.*?)"$/) do |text|
  click_link_or_button(text, match: :first)
end


When(/^I fill out the (.*?) with the following data$/) do |form, table|
	puts form 

	case form 
	when 'basics'
		fill_in_basics_form(table)
	when 'about you'
		fill_in_about_you_form(table)
	when 'availability and services'
		fill_in_availability_and_services_form(table)
	when 'education and experiences'
		fill_in_education_and_experience_form(table)
	end
end

Given(/^I fill out the family registration form$/) do
  
  fill_in 'user[first_name]', with: 'Kyle'
  fill_in 'user[last_name]', with: 'Szives'
  fill_in 'user[email]', with: 'testemail@example.com'
  fill_in 'user[password]', with: 'password1'

end


Then(/^I should see "(.*?)"$/) do |potential_text|
	page.should have_content(potential_text)
end

Then(/^show me the page$/) do
  save_and_open_page
end