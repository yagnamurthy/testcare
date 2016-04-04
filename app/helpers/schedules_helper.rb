module SchedulesHelper

	def build_row schedule, time_in_words
		html = ''
		["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"].each do |time|

			bool = schedule ? schedule.send(time + "_" + time_in_words) : false

			html += "<td><span class='"
			html += bool ? 'check' : 'uncheck'
			html += "'></span></td>"
		end
		raw html
	end

end
