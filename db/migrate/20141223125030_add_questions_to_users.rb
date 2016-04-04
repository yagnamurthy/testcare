class AddQuestionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :question_1, :text
    add_column :users, :question_2, :text
    add_column :users, :question_3, :text
    add_column :users, :question_4, :text
  end
end
