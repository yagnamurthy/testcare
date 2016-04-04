class User::Availability

	LIVEIN = { label: 'Live in', value: 1 }
	PARTTIME = { label: 'Part Time (20-30 hours a week)', value: 2 }
	FULLTIME = { label: 'Full Time (40+ hours a week)', value: 3 }
	OCCASIONAL = { label: 'Occasional (Less than 20 hours a week)', value: 4 }

	VALUES= [ 
		LIVEIN[:value],
		PARTTIME[:value],
		FULLTIME[:value],
		OCCASIONAL[:value]
	]

  def self.label value
  	case
  	when value == LIVEIN[:value] then LIVEIN[:label]
  	when value == PARTTIME[:value] then PARTTIME[:label].split('(')[0].strip
  	when value == FULLTIME[:value] then FULLTIME[:label].split('(')[0].strip
  	when value == OCCASIONAL[:value] then OCCASIONAL[:label].split('(')[0].strip
  	end
  end

	def self.options_for_select
		[
			['Live In', '1'],
			['Live Out', '0'],
			['Either', '0']
		]
	end

end