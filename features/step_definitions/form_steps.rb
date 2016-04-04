# When(/^I fill out the form with this data$/) do |table|
#   rows = table.rows_hash

#   rows.each do |attr, value|
#   	if page.has_xpath?('//input/' + attr.downcase.gsub(" ", "_"))
#   		fill_in attr.downcase.gsub(" ", "_"), with: value 
#   	else
#   		puts "#{attr} wasnt filled out in anyway"
#   	end
#   end
# end

When(/^I fill out the (.*?) form with this data$/) do |type, table|
	rows = table.rows_hash

	case type
	when 'job'
		fill_in "contract[patient_name]", with: rows["Patient Name"]
		fill_in "contract[headline]", with: rows["Headline"]
		fill_in "contract[description]", with: rows["Description"]

		select rows["Hours Needed"],  from: "contract[hours_needed]"

		fill_in "contract[zipcode]", with: rows["Zipcode"]
		fill_in "contract[phone]", with: rows["Phone"]

		choose rows["Job Type"]

		fill_in "contract[required_rate]", with: rows["Required Rate"]

		check rows["Service Ids"]
		check rows["Requirement Ids"]
	when 'shared_connections'
		check rows['Affiliate Ids']
	end
end

When(/^then press submit$/) do
  click_button 'Save & Continue'
end

When(/^I fill out the reference form correctly$/) do
  select 'coworker', from: 'reference[relationship]'
  fill_in 'reference[body]', with: 'This is a sample reference'

  if page.has_xpath?("//reference[name]")
  	fill_in 'reference[name]', with: 'Name'
  end
end

When(/^I fill out the reference form incorrectly$/) do
  select 'coworker', from: 'reference[relationship]'
end


