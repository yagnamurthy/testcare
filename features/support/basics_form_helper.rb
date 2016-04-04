module BasicFormHelper

	def fill_in_basics_form table
		rows = table.rows_hash

		select rows['Date of Birth Month'], from: 'basics[date_of_birth_month]'
		select rows['Date of Birth Day'], from: 'basics[date_of_birth_day]'
		select rows['Date of Birth Year'], from: 'basics[date_of_birth_year]'
		fill_in 'basics[zipcode]', with: rows['Zipcode']
		fill_in 'basics[phone]', with: rows['Phone']

		select rows['Language'], from: 'Language ids'

		choose rows['Gender']
		choose rows['Smoking']
		choose rows['Pets']
		choose rows['Transportation']

		check rows['Allergy']

		submit
	end

	def fill_in_about_you_form table
		rows = table.rows_hash

		fill_in 'about_you[headline]', with: rows['Headline']
		fill_in 'about_you[bio]', with: rows['Bio']

		check rows['Affiliate']

		submit
	end

	def fill_in_availability_and_services_form table
		fill_in 'availability_and_services[hourly_rate]', with: 15

		choose 'Live in'

		check 'availability_and_services_schedule_attributes_monday_morning'
		check 'Baking'
		check 'Vitals'
		check 'Stroke'

		submit
	end

	def fill_in_education_and_experience_form table

		fill_in 'education_and_experience_work_experience', with: 15

		check 'Other'

		fill_in 'education_and_experience[schools_attributes][0][name]', with: 'This is a name'
		select '2010', from: 'education_and_experience_schools_attributes_0_start_date_year'
		select '2011', from: 'education_and_experience_schools_attributes_0_finish_date_year'
		select "Master's Degree", from: 'education_and_experience_schools_attributes_0_degree'
		fill_in 'education_and_experience_schools_attributes_0_description', with: 'This is description'

		fill_in 'education_and_experience_experiences_attributes_0_employer', with: 'My Employer'
		fill_in 'education_and_experience_experiences_attributes_0_position', with: 'Position here'
		select 'July', from: 'education_and_experience_experiences_attributes_0_start_date_month'
		select '2011', from: 'education_and_experience_experiences_attributes_0_start_date_year'
		select 'July', from: 'education_and_experience_experiences_attributes_0_finish_date_month'
		select '2012', from: 'education_and_experience_experiences_attributes_0_finish_date_year'
		fill_in 'education_and_experience_experiences_attributes_0_description', with: 'Description here'

		submit
		
	end

	def submit
		click_button 'Save & Continue'
	end
end

World(BasicFormHelper)