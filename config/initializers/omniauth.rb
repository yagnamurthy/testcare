if Rails.env.production?
 ENV['FACEBOOK_APP_ID'] = '148451566786'
 ENV['FACEBOOK_SECRET'] = 'e10f2d27ea723ac6cd706bc6c9c05376'
else
  ENV['FACEBOOK_APP_ID'] = '253774201332490'
  ENV['FACEBOOK_SECRET'] = '80905c57ec5954c1504360fc5310fd02'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'],
  	:provider_ignores_state => true,
  	:scope => 'email,user_birthday,user_location,user_education_history,user_photos', 
  	:display => 'page',
  	:image_size => 'large',
  	:info_fields => 'id,first_name,last_name,gender,link,birthday,location,picture,work'
end