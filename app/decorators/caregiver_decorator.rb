class CaregiverDecorator < Draper::Decorator
  include Draper::LazyHelpers

  delegate_all

  def headline
    object.headline.presence ? object.headline : nil
  end

  def top_skills
    list_services skill_services
  end

  def has_top_skills?
    has? skill_services
  end

  def skills
  	list_services technical_services
  end

  def has_skills?
    has? technical_services
  end

  def services
  	list_services general_services
  end

  def has_services?
    has? general_services
  end

  def experience_with
  	list_services health_services
  end

  def has_experience_with?
    has? health_services
  end

  def has_education?
    has? schools
  end

  def education_list
    render partial: 'schools/school', collection: schools.order("finish_date_year DESC")
  end

  def has_experience?
    has? experiences
  end

  def experience_list
    render partial: 'experiences/experience', collection: experiences.order("finish_date DESC")
  end

  def testimonial_count
    object.references.count
  end

  def hourly_rate_estimate
    object.hourly_rate.presence ?
      "$#{object.hourly_rate - 2}-#{object.hourly_rate + 2}/hr" :
        'N/A'
  end

  def allergies_names
    if object.allergies.length > 0
      object.allergies.pluck(:name).join(', ')
    else
      'None'
    end
  end

  def total_score
    score = 0

    score += individual_score(:dependability)
    score += individual_score(:technical_ability)
    score += individual_score(:communication_skills)
    score += individual_score(:compassion)

    score / 4
  end

  def testimonials_list
    if testimonial_count > 0
      object.references
    else
      []
    end
  end

  def individual_score key
    testimonials = object.references.reject { |r| r.send(key).nil? }
    score = 0

    return score if testimonials.count == 0

    testimonials.each do |testimonial|
      score += testimonial.send(key)
    end


    score / testimonials.count
  end

  private

  def list_services array_values
  	unless array_values.empty?
  		h.content_tag :ul do
  			array_values.collect { |item| h.content_tag :li, item.name }.join.html_safe
  		end
  	end
  end

  def has? array_values
    array_values && array_values.length > 0
  end

end
