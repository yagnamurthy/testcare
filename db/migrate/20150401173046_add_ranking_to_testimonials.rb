class AddRankingToTestimonials < ActiveRecord::Migration
  def change
    add_column :references, :dependability, :integer
    add_column :references, :technical_ability, :integer
    add_column :references, :communication_skills, :integer
    add_column :references, :compassion, :integer

    Reference.all.each do |reference|
      reference.dependability = 5
      reference.technical_ability = 5
      reference.communication_skills = 5
      reference.compassion = 5
      reference.save(validate: false)
    end
  end
end
