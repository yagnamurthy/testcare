class User::Transportation

	YES = { value: 1, label: 'Yes' }
	SOMETIMES = { value: 2, label: 'Yes, but only on certain days' }
	NO = { value: 3, label: 'No, but I do have a driver\' license.' }

	VALUES = [
		NO[:value],
		SOMETIMES[:value],
		YES[:value]
	]

  def self.label value
  	case
  	when value == YES[:value] then YES[:label]
  	when value == SOMETIMES[:value] then SOMETIMES[:label]
  	when value == NO[:value] then NO[:label]
  	end
  end

	def self.options_for_select
		[
			["Optional", "0"],
			["Required", YES[:value]],
			["Not Required", "0"]
		]
	end
end