class CreateAdditionUserQuestions < ActiveRecord::Migration
  def change
    create_table :addition_user_questions do |t|
      t.text 	  :answer
      t.integer   :question_id
      t.references :user
    end
  end
end