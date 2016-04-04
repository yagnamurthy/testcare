class User::Pets

	LOVE = { value: 1, label: 'I love pets' }
	ALLERGICDOGS = { value: 2, label: 'I\'m allergic to dogs' }
	ALLERGICCATS = { value: 3, label: 'I\'m allergic to cats' }
	ALLERGICBOTH = { value: 4, label: 'I\'m allergic to cats and dogs' }
	DEPENDS = { value: 5, label: 'Depends on the pet' }
	NO = { value: 6, label: 'No pets please' }

	VALUES = [
		LOVE[:value],
		ALLERGICDOGS[:value],
		ALLERGICCATS[:value],
		ALLERGICBOTH[:value],
		DEPENDS[:value],
		NO[:value]
	]

  def self.label value
  	case
  	when value == LOVE[:value] then LOVE[:label]
  	when value == ALLERGICDOGS[:value] then ALLERGICDOGS[:label]
  	when value == ALLERGICCATS[:value] then ALLERGICCATS[:label]
  	when value == ALLERGICBOTH[:value] then ALLERGICBOTH[:label]
	when value == DEPENDS[:value] then DEPENDS[:label]
  	when value == NO[:value] then NO[:label]
  	end
  end

end