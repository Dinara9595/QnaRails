class User < ApplicationRecord
  has_many :questions, class_name: 'Question', foreign_key: 'user_id', dependent: :destroy
  has_many :answers, class_name: 'Answer', foreign_key: 'user_id', dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def author_of?(resource)
    id == resource.user_id
  end
end
