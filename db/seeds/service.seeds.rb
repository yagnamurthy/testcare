require "rubygems"

services = [
 [ '1', [ 'Cooking', 'GeneralService' ] ],
 [ '2', [ 'Bathing, Dressing, Grooming', 'GeneralService' ] ],
 #[ '3', [ 'Exercise & Physical Activities', 'GeneralService' ] ],
 [ '4', [ 'Eating Assistance', 'GeneralService' ] ],
 # [ '5', [ 'Gastrointestinal Care', 'GeneralService' ] ],
 [ '6', [ 'Laundry', 'GeneralService' ] ],
 [ '7', [ 'Light HouseKeeping', 'GeneralService' ] ],
 [ '8', [ 'Mobility Assistance', 'GeneralService' ] ],
 [ '9', [ 'Medication Management', 'GeneralService' ] ],
 # [ '10', [ 'Meal Preparation', 'GeneralService' ] ],
 [ '11', [ 'Pet Care', 'GeneralService' ] ],
 [ '12', [ 'Shopping and Errands', 'GeneralService' ] ],
 [ '13', [ 'Transfer Assistance', 'GeneralService' ] ],
 [ '14', [ 'Toileting', 'GeneralService' ] ],
 # [ '15', [ 'Tracheotomy Care', 'GeneralService' ] ],
 # [ '16', [ 'Transportation', 'GeneralService' ] ],
 # [ '17', [ 'Ventilation Trained', 'GeneralService' ] ],
 [ '18', [ 'Other', 'GeneralService' ] ],
 # [ '19', [ 'Companionship', 'GeneralService' ] ],
 # [ '20', [ 'Massage', 'GeneralService' ] ],
 # [ '21', [ 'Shaving', 'GeneralService' ] ],
 [ '22', [ 'Amyotrophic Lateral Sclerosis', 'HealthService' ] ],
 [ '23', [ 'Alzheimer\'s/Dementia', 'HealthService' ] ],
 [ '24', [ 'Blood Disorders', 'HealthService' ] ],
 [ '25', [ 'Cancer Recovery', 'HealthService' ] ],
 [ '26', [ 'Cardiovascular Disorders', 'HealthService' ] ],
 [ '27', [ 'Diabetes', 'HealthService' ] ],
 [ '28', [ 'Gastrointestinal Disorders', 'HealthService' ] ],
 [ '29', [ 'Hospice Care', 'HealthService' ] ],
 [ '30', [ 'Multiple Sclerosis', 'HealthService' ] ],
 [ '31', [ 'Neurological Disorders', 'HealthService' ] ],
 [ '32', [ 'Orthopedic Care', 'HealthService' ] ],
 [ '33', [ 'Parkinson\'s Disease', 'HealthService' ] ],
 [ '34', [ 'Post Surgery Recovery', 'HealthService' ] ],
 [ '35', [ 'Respiratory Disorders', 'HealthService' ] ],
 [ '36', [ 'Stroke', 'HealthService' ] ],
 [ '37', [ 'Skin Disorders', 'HealthService' ] ],
 [ '38', [ 'HIV/AIDS', 'HealthService' ] ],
 [ '39', [ 'LGBT Health', 'HealthService' ] ],
 [ '40', [ 'Other', 'HealthService' ] ],
 [ '41', [ 'Gastrointestinal Care', 'TechnicalService' ] ],
 [ '42', [ 'Geriatric Trained', 'TechnicalService' ] ],
 [ '43', [ 'Hospice Experience', 'TechnicalService' ] ],
 [ '44', [ 'Licensed Massage Therapist', 'TechnicalService' ] ],
 [ '45', [ 'Tracheotomy Care', 'TechnicalService' ] ],
 [ '46', [ 'Transfer Assistance', 'TechnicalService' ] ],
 [ '47', [ 'Ventilation Trained', 'TechnicalService' ] ],
 [ '48', [ 'Vitals', 'TechnicalService' ] ],
 [ '49', [ 'Other', 'TechnicalService' ] ],
 #[ '50', [ 'Hoyer Lift', 'GeneralService'] ],
 [ '51', [ 'Compassion', 'SkillService'] ],
 [ '52', [ 'Patience', 'SkillService'] ],
 [ '53', [ 'Good at talking with seniors', 'SkillService'] ],
 [ '54', [ 'Great Cook', 'SkillService'] ],
 [ '55', [ 'Highly Organized', 'SkillService'] ],
 [ '56', [ 'Dependable', 'SkillService'] ],
 [ '57', [ 'Great caregiving technical knowledge', 'SkillService'] ],
 [ '58', [ 'Activities', 'SkillService'] ],
 [ '59', [ 'Health and fitness with seniors', 'SkillService'] ],
 [ '60', [ 'Highly empathetic', 'SkillService'] ],
 [ '61', [ 'Lots of caregiving experience', 'SkillService'] ],
 [ '62', [ 'Team player', 'SkillService'] ],
 [ '63', [ 'Nutrition expert', 'SkillService'] ],
 [ '64', [ 'Great sense of humor', 'SkillService'] ],
 [ '65', [ 'Massage Therapist', 'SkillService'] ],
 [ '66', [ 'Hospice experience', 'SkillService'] ],
 [ '67', [ 'Spirituality', 'SkillService'] ],
]

Service.delete_all

services.each do |service|
	@service = Service.create!(id: service[0], name: service[1][0], type: service[1][1])
	puts "#{@service.name} was created as a #{@service.type}" if Rails.env.development? || Rails.env.production?
end
