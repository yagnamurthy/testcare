namespace :elasticsearch do

  desc "reindexes the elasticsearch index"
  task reindex: :environment do
  	Caregiver.index.delete
  	Caregiver.create_elasticsearch_index
  	Caregiver.index.refresh
  	Rake::Task['tire:import:all'].invoke()
  end

end
