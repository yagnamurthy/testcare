class ChangeQuestionToRow < ActiveRecord::Migration
  def change
  	rename_table :addition_user_questions, :questions

  	remove_column :questions, :answer
  	remove_column :questions, :question_id
  	
  	add_column :questions, :q1, :string
  	add_column :questions, :q2, :string
  	add_column :questions, :q3, :string
  	add_column :questions, :q4, :string
  end
end
