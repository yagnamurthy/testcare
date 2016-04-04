if Rails.env.production? || Rails.env.staging?
	Tire.configure { logger $stdout, :level => 'debug' }
	ENV['ELASTICSEARCH_URL'] = ENV['BONSAI_URL'] #'http://pxq5i2lw:9zqd1vkb56vov132@maple-3167444.us-east-1.bonsai.io'
	INDEX_NAME = "caregivers"

elsif Rails.env.test?
  prefix = "#{Rails.application.class.parent_name.downcase}_#{Rails.env.to_s.downcase}_"
  Tire::Model::Search.index_prefix(prefix)

end