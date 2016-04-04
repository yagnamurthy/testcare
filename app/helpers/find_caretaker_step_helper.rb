module FindCaretakerStepHelper
  def who_needs_options
    [['My Mother', 'mother'],
     ['My Father', 'father'],
     ['My Grandmother', 'grandmother'],
     ['My Grandfather', 'grandfather'],
     ['My wife', 'wife'],
     ['My Husband', 'husband'],
     ['My Female partner', 'female partner'],
     ['My Male partner', 'male partner'],
     ['My Sister', 'sister'],
     ['My Brother', 'brother'],
     ['Myself (female)', 'female'],
     ['Myself (male)', 'male'],
     ['My Female relative', 'female relative'],
     ['My Male relative', 'male relative'],
     ['My female friend', 'female friend'],
     ['My Male friend', 'male friend']]
  end

  def patient_gender(patient)
    if patient == 'mother' || patient == 'wife' || patient.include?('female') || patient.include?('sister')
      'she'
    else
      'he'
    end
  end

  def third_person(key)
    if key == 'she'
      'her'
    else
      'his'
    end
  end

  def care_types
    ['Bathing','Grooming', 'Toileting', 'Managing Medications', 'Meal Prep', 'Groceries & Shopping', 'Transferring & Mobility', 'Exercise', 'Transportation', 'Housekeeping', 'Companionship']
  end

  def time_of_care
    [['Morning', '0'], ['Afternoon', '1'], ['Evening', '2'], ['Overnight', '3']]
  end

  def day_of_week
    [['M', 'Monday'], ['T', 'Tuesday'], ['W', 'Wednesday'], ['T', 'Thursday'], ['F', 'Friday'], ['S', 'Saturday'], ['S', 'Sunday']]
  end
end
