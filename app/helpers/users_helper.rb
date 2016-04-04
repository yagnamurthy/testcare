module UsersHelper
  require 'area'
  require_dependency 'zip_code_converter'

  def avatar_image_link_to_profile reference, size, classes_on_image

    if reference.caregiver?
      link_to reference do
        avatar_tag reference, size, class: classes_on_image
      end
    else
      avatar_tag reference, size, class: classes_on_image
    end
  end

  def name_link_to_profile reference
    if reference.caregiver?
      link_to reference.first_and_last_initial, reference
    else
      content_tag :span, reference.first_and_last_initial
    end
  end

  def avatar_tag user, type=:large, options={}
    if user && user.avatar
      case type
      when :large
        image_tag(user.avatar.url(:large), options)
      when :medium
        image_tag(user.avatar.url(:medium), options)
      when :thumb
        image_tag(user.avatar.url(:thumb), options)
      end
    else
      ''
    end
  end

  def round_hours hours
    case hours.to_i
    when 1..19 then hours.to_i > 0 ? hours : 1
    when 20..50 then 20.to_s + "+"
    when 50..100 then 50.to_s + "+"
    when 100..250 then 100.to_s + "+"
    when 250..500 then 250.to_s + "+"
    when 500..1000 then 500.to_s + "+"
    when 1000..2000 then 1000.to_s + "+"
    when 2000..3000 then 2000.to_s + "+"
    end
  end

  def show_extended_list? current_user
    (current_user && current_user.indexable) || (current_user && !current_user.caregiver?)
  end

  def formatted_hourly_rate rate
    html = ''
    rate = number_to_currency(rate, precision: 2)

    if rate
      rate = rate.split('.')
      html += rate[0]
      html += "<span class='cents'>.#{rate[1]}</span>"
    else
      html += "00"
      html += "<span class='cents'>.00</span>"
    end
    raw(html)
  end

  def step_finished step, num
    step < num ? 'step-finished' : ''
  end

  def distance_in_miles distance
    mi = distance.ceil
    "#{mi} #{mi > 1 ? 'miles'.pluralize : 'mile'}"
  end

  def generate_tags user
    if user.tags.length > 0
      html = '<i class="icon-tags"></i> Services: '
      user.tags.each do |t|
        html += "<a href=\"#\"><span class=\"label label-info\">#{t.name}</span></a>"
      end
    end
    html
  end

  def computed_location location_info
    region = Geocoder.search(location_info).first
    if region.postal_code
      "#{region.city}, #{region.state} (#{region.postal_code})"
    else
      "#{region.city}, #{region.state}"
    end
  end

  def advanced_search_checkbox str, service_id, checked
    label = '<div>'
    label += '</div>'

    label += check_box_tag "s[services][#{service_id.to_s}]", service_id.to_s, false, {class: 'styled', checked: checked, id: service_id.to_s.gsub(' ', '-')}
    label += "<label class='inline padding-left' for='#{service_id.to_s.gsub(' ', '-')}'>"
    label += str +  ' '
    label += '</label>'

    raw(label)
  end

  def link_to_if_testimonial condition, &block
    if condition
     link_to &block
    end
  end
end
