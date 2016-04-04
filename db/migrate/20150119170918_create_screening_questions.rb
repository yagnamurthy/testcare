class CreateScreeningQuestions < ActiveRecord::Migration
  def change
    create_table :screening_questions do |t|
      t.text        :question
      t.references   :contract
      t.timestamps
    end
  end
end
