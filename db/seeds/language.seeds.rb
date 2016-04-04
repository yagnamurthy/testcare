require "rubygems"
require "yaml"

langauges = YAML.load_file("#{Rails.root}/lib/assets/languages.yml")

Language.delete_all

langauges.each do |key, value|
	Language.create({
		name: value["name"],
		code: key.upcase
	})
	puts "#{value['name']} was created!" if Rails.env.development? || Rails.env.production?
end




