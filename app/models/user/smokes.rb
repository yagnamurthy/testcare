class User::Smokes
  YES = { value: 1, label: 'Yes' }
  NOTATWORK = { value: 2, label: 'Yes, but not at work' }
  NO = { value: 3, label: 'No' }

  VALUES = [
    YES[:value],
    NOTATWORK[:value],
    NO[:value]
  ]

  def self.label value
  	case
  	when value == YES[:value] then YES[:label]
  	when value == NOTATWORK[:value] then NOTATWORK[:label]
  	when value == NO[:value] then NO[:label]
  	end
  end
end