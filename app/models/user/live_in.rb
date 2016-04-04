class User::LiveIn
  YES = { value: 1, label: 'Yes' }
  NO = { value: 0, label: 'No' }

  VALUES = [
    YES[:value],
    NO[:value]
  ]

  def self.label value
    case
      when value == YES[:value] then YES[:label]
      when value == NO[:value] then NO[:label]
    end
  end
end
