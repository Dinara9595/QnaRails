class AddUserToAnswers < ActiveRecord::Migration[6.1]
  def change
    add_reference :answers, :user, null: false, foreign_key: true
    add_reference :users, :answer, null: true, foreign_key: true
  end
end
