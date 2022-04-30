class AddUserToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :user, null: false, foreign_key: true
    add_reference :users, :question, null: true, foreign_key: true
  end
end
