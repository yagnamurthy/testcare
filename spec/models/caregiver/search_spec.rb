require 'spec_helper'
require 'json'

describe Caregiver::Search do

	before(:each) do
		@params = HashWithIndifferentAccess.new({"zipcode"=>"15217"})
		@subject = Caregiver::Search.new(@params)
	end

	describe '#zipcode' do
		it 'sets zipcode' do
			@subject.zipcode="15217"
			@subject.zipcode.should eq("15217")
		end

		it 'sets lat and lng' do
			@subject.zipcode="15217"
			@subject.lat_lng.should eq("40.430919, -79.92569")
		end

		it 'raises exception when no zipcode' do
			expect { @subject.zipcode=nil }.to raise_error
		end
	end

	describe '#gender' do
		it 'sets gender' do
			@subject.gender="1"
			@subject.gender.should eq(1)
		end

		it 'sets gender when gender nil' do
			@subject.gender="5"
			@subject.gender.should eq(nil)
		end
	end

	describe '#wage' do
		it 'sets range wage' do
			@subject.wage ="35-40"
			@subject.wage[:from].should eq(35)
			@subject.wage[:to].should eq(40)
		end

		it 'sets wage range when nil' do
			@subject.wage=nil
			@subject.wage[:from].should eq(1)
			@subject.wage[:to].should eq(50)
		end
	end

	describe '#services' do
		it 'converts hash of services to array' do
			@subject.services= HashWithIndifferentAccess.new({"1000" => "1"})
			@subject.services.should eq(["1000"])
		end

		it 'convert services to nil when all zeros' do
			@subject.services = []
			@subject.services.should eq(nil)
		end
	end

	describe '#transportation' do
		it 'sets transportation as int' do
			@subject.transportation ="1"
			@subject.transportation.should eq(1)
		end

		it 'sets transportation to nil if zero' do
			@subject.transportation="0"
			@subject.transportation.should eq(nil)
		end
	end

	describe '#keywords' do
		it 'sets keywords when present' do
			@subject.keywords="waffles"
			@subject.keywords.should eq("waffles")
		end

		it 'sets keywords as nil when blank' do
			@subject.keywords=""
			@subject.keywords.should eq(nil)
		end
	end

	describe '#work_experience' do
		it 'sets work experience' do
			@subject.work_experience=15
			@subject.work_experience[:from].should eq(15)
			@subject.work_experience[:to].should eq(30)
		end

		it 'sets default work experience when empty' do
			@subject.work_experience=nil
			@subject.work_experience[:from].should eq(1)
			@subject.work_experience[:to].should eq(30)
		end
	end

	describe '#language' do
		it 'sets language' do
			@subject.language="EN"
			@subject.language.should eq("EN")
		end

		it 'sets language as nil when language is empty' do
			@subject.language=""
			@subject.language.should eq(nil)
		end
	end

	describe '#has_hospice' do
		it 'sets hospice' do
			@subject.has_hospice="1"
			@subject.has_hospice.should eq(true)
		end

		it 'sets hospice as nil when false' do
			@subject.has_hospice="0"
			@subject.has_hospice.should eq(nil)
		end

		it 'sets hospice as nil when nil' do
			@subject.has_hospice=nil
			@subject.has_hospice.should eq(nil)
		end
	end

	describe '#search' do

		before(:each) do
    	Caregiver.index.delete
    	Caregiver.create_elasticsearch_index
		end

		context 'searches based on gender' do
			it 'when gender is present' do
				@subject.gender="1"

				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', gender: 1, zipcode: '15217', hourly_rate: '20', indexable: true) }
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', gender: 2, zipcode: '15217', hourly_rate: '20', indexable: true) }

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(2)
			end

			it 'when gender is nil' do
				@subject.gender=nil

				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', gender: 1, zipcode: '15217', hourly_rate: '20', indexable: true) }
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', gender: 2, zipcode: '15217', hourly_rate: '20', indexable: true) }

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(4)
			end
		end

		context 'searches based on transportation' do
			it 'when transportation is present' do
				@subject.transportation=1

				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', transportation: 1, zipcode: '15217', hourly_rate: '20', indexable: true) }
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', transportation: 2, zipcode: '15217', hourly_rate: '20', indexable: true) }
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', transportation: 3, zipcode: '15217', hourly_rate: '20', indexable: true) }

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(4)
			end

			it 'when transportation is nil' do
				@subject.transportation=nil

				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', transportation: 1, zipcode: '15217', hourly_rate: '20', indexable: true) }
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', transportation: 2, zipcode: '15217', hourly_rate: '20', indexable: true) }
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', transportation: 3, zipcode: '15217', hourly_rate: '20', indexable: true) }

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(6)
			end
		end

		context 'searches based on hourly rate' do
			it 'when hourly range is within range' do
				@subject.wage="20-30"
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', transportation: 1, zipcode: '15217', hourly_rate: '15', indexable: true) }
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', transportation: 2, zipcode: '15217', hourly_rate: '25', indexable: true) }

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(2)
			end

			it 'when hourly range is nil' do
				@subject.wage=nil
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '4', indexable: true) }
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true) }

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(4)
			end
		end

		context 'searches based on keywords' do
			it 'when keywords is present' do
				@subject.keywords="bio"
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', bio: 'This is my bio', headline: 'This is my', hourly_rate: '20', indexable: true) }
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', bio: 'This is also my', headline: 'this his my bio', hourly_rate: '20', indexable: true) }

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(4)
			end

			it 'when searching for name' do
				@subject.keywords="Kyle Sziv"
				2.times { |i| Caregiver.create!(first_name: 'Kyle', last_name: 'Szives', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', bio: 'This is my bio', headline: 'This is my', hourly_rate: '20', indexable: true) }
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', bio: 'This is also my', headline: 'this his my bio', hourly_rate: '20', indexable: true) }

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(2)
			end

			it 'when searching schools' do
				School.create!(degree: 1, start_date_year: DateTime.now.year, finish_date_year: DateTime.now.year, name: 'Central Penn College')

				@subject.keywords="Central Penn"

				@caregiver = Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)
				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)

				@caregiver.schools = School.all

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(1)

			end

			it 'when keywords is nil' do
				@subject.keywords=nil
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', bio: 'This is my bio', headline: 'This is my', hourly_rate: '20', indexable: true) }
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', bio: 'This is also my', headline: 'this his my bio', hourly_rate: '20', indexable: true) }

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(4)
			end
		end

		context 'search based on language' do
			it 'when language is present' do
				@subject.language="EN"

				2.times do |i|
					@caregiver = Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)
					@caregiver.languages << Language.where(code: "EN")
				end

				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217',  hourly_rate: '20', indexable: true) }

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(2)
			end

			it 'when language is nil' do
				@subject.language=nil
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', bio: 'This is my bio', headline: 'This is my', hourly_rate: '20', indexable: true) }
				2.times { |i| Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', bio: 'This is also my', headline: 'this his my bio', hourly_rate: '20', indexable: true) }

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(4)
			end
		end

		context 'search based on RN certification' do
			it 'when RN is present' do
				@subject.is_RN=true
				@caregiver = Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)
				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)

				@caregiver.build_credential({RN: true})
				@caregiver.save!

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(1)
			end
		end

		context 'search based on LVN certification' do
			it 'when LVN is present' do
				@subject.is_LVN=true
				@caregiver = Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)
				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)

				@caregiver.build_credential({LVN: true})
				@caregiver.save!

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(1)
			end
		end

		context 'search based on HHA certification' do
			it 'when HHA is present' do
				@subject.is_HHA=true
				@caregiver = Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)
				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)

				@caregiver.build_credential({HHA: true})
				@caregiver.save!

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(1)
			end
		end

		context 'search based on CNA certification' do
			it 'when CNA is present' do
				@subject.is_CNA=true
				@caregiver = Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)
				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)

				@caregiver.build_credential({CNA: true})
				@caregiver.save!

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(1)
			end
		end

		context 'search based on allergies' do
			it 'when allergies is present' do
				Allergy.create!(name: 'Cat')

				@subject.no_allergies=true

				@caregiver = Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)
				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)

				@caregiver.allergies = Allergy.all

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(1)
			end
		end

		context 'search based on services' do
			it 'when services is present' do
				Service.create!(name: 'Home Care')

				@subject.services= HashWithIndifferentAccess.new({ Service.all.first.id => '1' })

				@caregiver = Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)
				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)

				@caregiver.services = Service.all

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(1)
			end
		end

		context 'searches based on degree' do
			it 'when degree is present' do
				School.create!(degree: 1, start_date_year: DateTime.now.year, finish_date_year: DateTime.now.year, name: 'test1')

				@subject.degree=true

				@caregiver = Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)
				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)

				@caregiver.schools = School.all

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(1)
			end
		end

		context 'searches based on hospice' do
			it 'when hospice is true' do
				@subject.has_hospice="1"

				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)
				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', hospice: true, indexable: true)

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(1)
			end

			it 'when hospice is nil' do
				@subject.has_hospice="0"

				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', indexable: true)
				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', hospice: false, indexable: true)

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(2)
			end
		end

		context 'searches based on pets' do
			it 'when pets if true' do
				@subject.likes_pets="1"

				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', pets: 2, indexable: true)
				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', pets: 1, indexable: true)

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(1)
			end

			it 'when pets if false' do
				@subject.likes_pets="0"

				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', pets: 2, indexable: true)
				Caregiver.create!(first_name: 'asdf', last_name: 'asdf', email: Faker::Internet.email, password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', pets: 1, indexable: true)

				Caregiver.import
				Caregiver.index.refresh

				@subject.search.results.length.should eq(2)
			end
		end

		context 'searches based on sort' do
			before(:each) do
	    	Caregiver.index.delete
	    	Caregiver.create_elasticsearch_index
				Caregiver.create!(email: Faker::Internet.email, first_name: 'Kyle', last_name: 'merp', password: 'somethingelse1', zipcode: '15217', hourly_rate: '20', hours: 20, references_count: 10, work_experience: 20, indexable: true, date_of_birth: DateTime.now - 25.years)
				Caregiver.create!(email: Faker::Internet.email, first_name: 'Patrick', last_name: 'merp', password: 'somethingelse1', zipcode: '15222', hourly_rate: '30', hours: 34, references_count: 1, work_experience: 30, indexable: true, date_of_birth: DateTime.now - 50.years)
				Caregiver.import
				Caregiver.index.refresh
			end

			it 'by distance' do
				@subject.sort = "2"
				@subject.search.results.first.first_name.should eq("Kyle")
			end

			# it 'by age, youngest' do
			# 	@subject.sort = "3"
			# 	@subject.search.results.first.first_name.should eq("Kyle")
			# end

			# it 'by age, oldest' do
			# 	@subject.sort = "4"
			# 	@subject.search.results.first.first_name.should eq("Patrick")
			# end

			it 'by carespotter hours' do
				@subject.sort = "5"
				@subject.search.results.first.first_name.should eq("Patrick")
			end

			it 'by work experience' do
				@subject.sort = "6"
				@subject.search.results.first.first_name.should eq("Patrick")
			end

			it 'testimonial count' do
				@subject.sort = "7"
				@subject.search.results.first.first_name.should eq("Patrick")
			end

			it 'by hourly rate' do
				@subject.sort = "8"
				@subject.search.results.first.first_name.should eq("Kyle")
			end
		end
	end
end
